# frozen_string_literal: true

require "json"

say "🤖 Adding universal LLM configuration files (Professional Setup)...", :magenta

# Robust check for template name
template_name = if defined?(TEMPLATE_NAME)
                  TEMPLATE_NAME
                elsif defined?(TEMPLATE_METADATA) && TEMPLATE_METADATA.is_a?(Hash)
                  TEMPLATE_METADATA[:name]
                else
                  "unknown"
                end
is_api_only = (template_name == "api")

say "   Template: #{template_name} (API only: #{is_api_only})", :cyan

# 1. Environment variables - Professional Separation
# .env: Shared defaults (non-sensitive)
env_defaults = <<~ENV
  # Shared development defaults
  DATABASE_URL="postgres://localhost/#{app_name}_development"
ENV

# .env.local: Local secrets (ignored by git)
env_secrets = <<~ENV
  # Local secrets and overrides
  GITHUB_PERSONAL_ACCESS_TOKEN=""
  CONTEXT7_API_KEY=""
ENV

# .env.example: Template for team members
create_file ".env.example", force: true do
  [env_defaults, env_secrets].join("\n")
end

# Create/Update .env (committed defaults)
create_file ".env", env_defaults, force: true

# Create .env.local (ignored secrets) if it doesn't exist
unless File.exist?(".env.local")
  create_file ".env.local", env_secrets
end

# 2. Update .gitignore for env management
if File.exist?(".gitignore")
  # Remove broad /.env* rule if it exists to allow committing .env
  gsub_file ".gitignore", /^\/\.env\*\n?/, ""
  
  # Ensure specific local envs are ignored
  append_to_file ".gitignore" do
    <<~GIT
      
      # Local environment variables (secrets)
      .env.local
      .env.*.local
    GIT
  end unless File.read(".gitignore").include?(".env.local")
end

# 3. Docker ignore - ensure local secrets don't leak into image
if File.exist?(".dockerignore")
  append_to_file ".dockerignore" do
    <<~DOCKER
      
      # Secrets and local overrides
      .env.local
      .env.*.local
    DOCKER
  end unless File.read(".dockerignore").include?(".env.local")
else
  create_file ".dockerignore", force: true do
    <<~DOCKER
      .env.local
      .env.*.local
      .git
      .github
      log/*
      tmp/*
    DOCKER
  end
end

# 4. Mise configuration - load both files (local overrides primary)
if File.exist?("mise.toml")
  mise_content = File.read("mise.toml")
  unless mise_content.include?('env_file = [".env", ".env.local"]')
    # Remove old single-file config if present
    gsub_file "mise.toml", /env_file = ".env"\n?/, ""
    
    if mise_content.include?("[tools]")
      gsub_file "mise.toml", /\[tools\]/, "[tools]\nenv_file = [\".env\", \".env.local\"]"
    else
      prepend_to_file "mise.toml", "env_file = [\".env\", \".env.local\"]\n\n"
    end
  end
end

# 5. Project-level Claude configuration (MCP)
create_file ".claude.json", force: true do
  # Helper script to load envs in order: .env then .env.local
  env_loader = 'if [ -f .env ]; then export $(grep -v "^#" .env | xargs); fi; if [ -f .env.local ]; then export $(grep -v "^#" .env.local | xargs); fi'

  mcp_servers = {
    "rails-mcp-server" => {
      "type" => "stdio",
      "command" => "/bin/bash",
      "args" => ["-lc", "rails-mcp-server"],
      "env" => {}
    },
    "postgres" => {
      "type" => "stdio",
      "command" => "/bin/bash",
      "args" => [
        "-c",
        "#{env_loader}; if [ -z \"$DATABASE_URL\" ]; then echo 'DATABASE_URL not found' >&2; exit 1; fi; npx -y @modelcontextprotocol/server-postgres \"$DATABASE_URL\""
      ],
      "env" => {}
    },
    "github" => {
      "type" => "stdio",
      "command" => "npx",
      "args" => ["-y", "@modelcontextprotocol/server-github"],
      "env" => {
        "GITHUB_PERSONAL_ACCESS_TOKEN" => "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }

  permissions_allow = [
    "Bash(npm:*)",
    "Bash(pnpm:*)",
    "Bash(yarn:*)",
    "Bash(bun:*)",
    "Bash(python3:*)",
    "Bash(ruby:*)",
    "Bash(rails:*)",
    "Bash(bundle:*)",
    "Bash(rake:*)",
    "Bash(bundle-audit:*)",
    "Bash(i18n-tasks:*)",
    "Bash(git:*)",
    "Bash(diff:*)",
    "Bash(grep:*)",
    "Bash(tail:*)",
    "Bash(head:*)",
    "Bash(ls:*)",
    "Bash(find:*)",
    "Bash(sed:*)",
    "Bash(mkdir:*)",
    "Bash(pkill:*)",
    "Read(./**)",
    "Edit(./**)",
    "WebFetch(domain:github.com)",
    "WebSearch",
    "Mcp(rails-mcp-server:*)",
    "Mcp(postgres:*)",
    "Mcp(github:*)"
  ]

  unless is_api_only
    mcp_servers["chrome-devtools"] = {
      "type" => "stdio",
      "command" => "npx",
      "args" => ["-y", "chrome-devtools-mcp@latest"],
      "env" => {}
    }
    mcp_servers["playwright"] = {
      "type" => "stdio",
      "command" => "npx",
      "args" => ["-y", "@playwright/mcp@latest"],
      "env" => {}
    }
    permissions_allow << "Mcp(chrome-devtools:*)"
    permissions_allow << "Mcp(playwright:*)"
  end

  mcp_servers["context7"] = {
    "type" => "http",
    "url" => "https://mcp.context7.com/mcp",
    "headers" => {
      "CONTEXT7_API_KEY" => "${CONTEXT7_API_KEY}"
    }
  }
  permissions_allow << "Mcp(context7:*)"

  JSON.pretty_generate({
    "mcpServers" => mcp_servers,
    "permissions" => {
      "allow" => permissions_allow,
      "deny" => [
        "Bash(rm:*)",
        "Bash(rmdir:*)",
        "Read(.env*)"
      ],
      "ask" => []
    }
  })
end

# 6. OpenCode project configuration
create_file "opencode.json", force: true do
  env_loader = 'if [ -f .env ]; then export $(grep -v "^#" .env | xargs); fi; if [ -f .env.local ]; then export $(grep -v "^#" .env.local | xargs); fi'

  mcp_configs = {
    "rails-mcp-server" => {
      "type" => "local",
      "enabled" => true,
      "command" => ["/bin/bash", "-lc", "rails-mcp-server"]
    },
    "postgres" => {
      "type" => "local",
      "enabled" => true,
      "command" => [
        "/bin/bash",
        "-c",
        "#{env_loader}; if [ -z \"$DATABASE_URL\" ]; then echo 'DATABASE_URL not found' >&2; exit 1; fi; npx -y @modelcontextprotocol/server-postgres \"$DATABASE_URL\""
      ]
    },
    "github" => {
      "type" => "local",
      "enabled" => true,
      "command" => ["npx", "-y", "@modelcontextprotocol/server-github"],
      "environment" => {
        "GITHUB_PERSONAL_ACCESS_TOKEN" => "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }

  permissions = {
    "bash" => "allow",
    "read" => "allow",
    "edit" => "allow",
    "grep" => "allow",
    "glob" => "allow",
    "list" => "allow",
    "lsp" => "allow",
    "skill" => "allow",
    "todowrite" => "allow",
    "todoread" => "allow",
    "websearch" => "allow",
    "webfetch" => "allow",
    "question" => "allow",
    "rails-mcp-server_*" => "allow",
    "postgres_*" => "allow",
    "github_*" => "allow"
  }

  unless is_api_only
    mcp_configs["chrome-devtools"] = {
      "type" => "local",
      "enabled" => true,
      "command" => ["npx", "-y", "chrome-devtools-mcp@latest"]
    }
    mcp_configs["playwright"] = {
      "type" => "local",
      "enabled" => true,
      "command" => ["npx", "-y", "@playwright/mcp@latest"]
    }
    permissions["chrome-devtools_*"] = "allow"
    permissions["playwright_*"] = "allow"
  end

  mcp_configs["context7"] = {
    "type" => "remote",
    "url" => "https://mcp.context7.com/mcp",
    "headers" => {
      "CONTEXT7_API_KEY" => "${CONTEXT7_API_KEY}"
    },
    "enabled" => true
  }
  permissions["context7_*"] = "allow"

  mcp_configs["sequential-thinking"] = {
    "type" => "local",
    "enabled" => true,
    "command" => ["npx", "-y", "@modelcontextprotocol/server-sequential-thinking"]
  }
  permissions["sequential-thinking_*"] = "allow"

  mcp_configs["repomix"] = {
    "type" => "local",
    "enabled" => true,
    "command" => ["npx", "-y", "repomix", "--mcp"]
  }
  permissions["repomix_*"] = "allow"

  JSON.pretty_generate({
    "mcp" => mcp_configs,
    "permission" => permissions
  })
end

# 7. .claudeignore — files Claude should not read/index
create_file ".claudeignore", force: true do
  <<~IGNORE
    node_modules/
    .git/
    log/
    tmp/
    coverage/
    public/assets/
    public/packs/
    .bundle/
    vendor/bundle/
    *.log
    *.lock
    dist/
  IGNORE
end

# 8. Multi-model instructions (project-specific)
ui_stack_line = case template_name
                when "api"              then "Rails 8 API"
                when "inertia_react"    then "Rails 8 + Inertia.js + React"
                when "inertia_vue"      then "Rails 8 + Inertia.js + Vue.js"
                when "inertia_svelte"   then "Rails 8 + Inertia.js + Svelte"
                when "esbuild_tailwind" then "Rails 8 + esbuild + Tailwind CSS"
                when "importmap_tailwind" then "Rails 8 + importmap + Tailwind CSS"
                else                    "Rails 8"
                end

ui_testing_section = unless is_api_only
  <<~MD

    ### chrome-devtools / playwright

    Use for browser-based testing and UI verification:
    - Take screenshots to verify layout and behavior
    - Fill forms and click through user flows
    - Assert on rendered HTML and network responses
    - Run E2E specs via `bin/rails spec:system` and inspect failures visually

  MD
end.to_s

llm_rules = <<~MARKDOWN
  # Development Guidelines

  ## Project Stack

  - **Framework**: #{ui_stack_line}
  - **Database**: PostgreSQL (via Solid Cache / Solid Queue for background jobs)
  - **Testing**: RSpec (unit + request specs#{is_api_only ? "" : " + system specs with Capybara/Playwright"})
  - **Background jobs**: Solid Queue (`bin/rails solid_queue:start`)
  - **Assets**: #{case template_name
                 when "api"               then "N/A (API only)"
                 when "inertia_react"     then "Vite + React (run with `bin/dev`)"
                 when "inertia_vue"       then "Vite + Vue.js (run with `bin/dev`)"
                 when "inertia_svelte"    then "Vite + Svelte (run with `bin/dev`)"
                 when "esbuild_tailwind"  then "esbuild + Tailwind CSS (run with `bin/dev`)"
                 when "importmap_tailwind" then "importmap + Tailwind CSS"
                 else                     "run with `bin/dev`"
                 end}

  ## Available MCP Tools

  Use MCP tools proactively — they provide live project context faster than grepping files.

  ### rails-mcp-server

  Use for Rails-aware introspection:
  - List and inspect routes, controllers, models, concerns
  - Read schema and database structure
  - Understand existing patterns before adding new code

  ### postgres

  Use for direct database queries:
  - Inspect table contents, run ad-hoc SQL to verify data state
  - Debug migration results or seed data
  - Requires `DATABASE_URL` from `.env` / `.env.local`
  #{ui_testing_section}
  ### context7

  Use for up-to-date library documentation:
  - Resolve correct API for Rails, RSpec, Inertia, React versions in use
  - Look up gem/package behaviour before assuming defaults
  - Call with `resolve-library-id` first, then `query-docs`

  ## Philosophy

  - **Incremental progress** — small changes that compile and pass tests
  - **Learn before implementing** — study existing patterns, find 3 similar features
  - **Pragmatic over dogmatic** — adapt to project reality
  - **Clear intent over clever code** — boring and obvious wins
  - **Ask when uncertain** — if confidence < 100%, ask clarifying questions before coding

  ### Core Principles

  | Principle | Meaning                         | Violation Sign                     |
  | --------- | ------------------------------- | ---------------------------------- |
  | **KISS**  | Simplest solution that works    | "Let me explain how this works..." |
  | **YAGNI** | Build only what's needed now    | "We might need this later..."      |
  | **DRY**   | Single source of truth          | Copy-pasting with minor changes    |
  | **SOLID** | Modular, replaceable components | God classes, tight coupling        |

  ## Process: Red-Green-Refactor

  **CRITICAL CHECKPOINT** — Before writing ANY production code:
  "Do I have a failing test for this behavior?"
  If NO → Write the test FIRST. No exceptions.

  1. **Red** — write failing test that defines expected behavior
  2. **Green** — write minimal code to pass (no more)
  3. **Refactor** — improve structure with tests green

  ## Technical Standards

  ### Rails & Architecture

  - Always use `bin/rails` (not `rails`) and `bin/dev` to start the server.
  - Follow Rails 8 defaults: Solid Queue for jobs, Solid Cache for caching.
  - Use `bin/rails db:migrate` — never manually edit schema.rb.
  - Background jobs go through Solid Queue; inspect with `bin/rails solid_queue:*`.
  - Composition over inheritance; dependencies injected, not hardcoded.

  ### Testing

  - **Unit / request specs**: RSpec. Write tests BEFORE production code.
  - **Run tests**: `bin/rails spec` or `bundle exec rspec`.#{is_api_only ? "" : "\n  - **System specs**: use Playwright MCP or Capybara to verify UI flows."}
  - Never disable tests or skip with `--no-verify`.

  ### Code Quality

  - Every change must compile, pass all existing tests, follow project conventions.
  - Descriptive, role-based names — no numbered variables.
  - Fail fast with context; never silently swallow exceptions.

  ## Rules

  **NEVER**: `--no-verify`, disable tests, commit code directly, assume without verifying, build for imaginary requirements, write production code before failing test.

  **ALWAYS**: ask if unsure, present work for review, update documentation, learn from existing code, stop after 3 failures, prefer deletion over addition, **TDD by default**.

  Use relative paths. Comments in English.
MARKDOWN

create_file "AGENTS.md", llm_rules, force: true
create_file "CLAUDE.md", llm_rules, force: true
