#!/bin/bash

# Kickstart Rails Template Installer
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/alec-c4/kickstart/master/install.sh)"

# Exit on error, unset variables, and pipe failures for safety
set -euo pipefail

#==============================================================================
# CONFIGURATION
#==============================================================================

# Repository details
readonly REPO_URL="https://raw.githubusercontent.com/alec-c4/kickstart/master"

# Template configuration (parallel arrays - compatible with bash 3.0+)
readonly AVAILABLE_TEMPLATES=("importmap_tailwind" "esbuild_tailwind" "inertia_svelte" "inertia_react" "inertia_vue" "api")

readonly TEMPLATE_DESCRIPTIONS=(
    "Rails app with Importmap and Tailwind CSS"
    "Rails app with ESBuild and Tailwind CSS"
    "Rails app with Inertia.js and Svelte 5 (SPA)"
    "Rails app with Inertia.js and React (SPA)"
    "Rails app with Inertia.js and Vue 3 (SPA)"
    "Rails API-only application"
)

readonly TEMPLATE_FLAGS=(
    "--skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind"
    "--skip-test --skip-system-test --database=postgresql --devcontainer --css=tailwind --javascript=esbuild"
    "--skip-test --skip-system-test --database=postgresql --devcontainer --skip-javascript"
    "--skip-test --skip-system-test --database=postgresql --devcontainer --skip-javascript"
    "--skip-test --skip-system-test --database=postgresql --devcontainer --skip-javascript"
    "--skip-test --skip-system-test --database=postgresql --devcontainer --api"
)

# Colors for output (compatible with most terminals)
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

#==============================================================================
# UTILITY FUNCTIONS
#==============================================================================

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}    Kickstart Rails Template Installer${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ Error: $1${NC}" >&2
}

print_warning() {
    echo -e "${YELLOW}⚠ Warning: $1${NC}" >&2
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

#==============================================================================
# VALIDATION FUNCTIONS
#==============================================================================

check_rails() {
    if ! command -v rails >/dev/null 2>&1; then
        print_error "Rails is not installed. Please install Rails first:"
        echo "  gem install rails"
        exit 1
    fi
    print_success "Rails found: $(rails --version)"
}

validate_app_name() {
    local app_name="$1"

    if [ -z "$app_name" ]; then
        print_error "App name is required"
        echo "Usage: $0 <app_name> [template_name]"
        exit 1
    fi

    if ! echo "$app_name" | grep -q '^[a-zA-Z][a-zA-Z0-9_-]*$'; then
        print_error "Invalid app name. Use letters, numbers, underscores, and hyphens. Must start with a letter."
        exit 1
    fi

    if [ -d "$app_name" ]; then
        print_error "Directory '$app_name' already exists"
        exit 1
    fi
}

validate_template() {
    local template_name="$1"

    for template in "${AVAILABLE_TEMPLATES[@]}"; do
        if [ "$template" = "$template_name" ]; then
            return 0
        fi
    done

    print_error "Template '$template_name' not found."
    show_templates >&2
    exit 1
}

#==============================================================================
# TEMPLATE FUNCTIONS
#==============================================================================

show_templates() {
    echo ""
    echo "Available templates:"
    for i in $(seq 0 $((${#AVAILABLE_TEMPLATES[@]} - 1))); do
        local template_name="${AVAILABLE_TEMPLATES[$i]}"
        local description="${TEMPLATE_DESCRIPTIONS[$i]}"
        echo "  $((i+1)). ${template_name} - ${description}"
    done
    echo ""
}

select_template() {
    local template_name="${1:-}"

    # Use provided template if given
    if [ -n "$template_name" ]; then
        validate_template "$template_name"
        echo "$template_name"
        return
    fi

    # Auto-select if only one template
    if [ ${#AVAILABLE_TEMPLATES[@]} -eq 1 ]; then
        echo "${AVAILABLE_TEMPLATES[0]}"
        return
    fi

    # Interactive selection
    show_templates >&2
    while true; do
        printf "Select template (1-${#AVAILABLE_TEMPLATES[@]}): " >&2
        read -r choice

        # Remove whitespace and validate
        choice=$(echo "$choice" | tr -d '[:space:]')
        if echo "$choice" | grep -q '^[0-9]\+$' && [ "$choice" -ge 1 ] && [ "$choice" -le ${#AVAILABLE_TEMPLATES[@]} ]; then
            echo "${AVAILABLE_TEMPLATES[$((choice-1))]}"
            return
        else
            print_warning "Invalid choice. Please select a number between 1 and ${#AVAILABLE_TEMPLATES[@]}."
        fi
    done
}

get_template_index() {
    local template_name="$1"

    for i in $(seq 0 $((${#AVAILABLE_TEMPLATES[@]} - 1))); do
        if [ "${AVAILABLE_TEMPLATES[$i]}" = "$template_name" ]; then
            echo "$i"
            return
        fi
    done

    echo "-1"
}

get_template_path() {
    local template_name="$1"
    local is_local="$2"

    if [ "$is_local" = "true" ]; then
        local script_dir="$(dirname "$0")"

        # Try current directory first, then script directory
        if [ -f "./${template_name}.rb" ]; then
            echo "$(pwd)/${template_name}.rb"
        elif [ -f "${script_dir}/${template_name}.rb" ]; then
            echo "${script_dir}/${template_name}.rb"
        else
            print_error "Local template file '${template_name}.rb' not found"
            exit 1
        fi
    else
        echo "${REPO_URL}/${template_name}.rb"
    fi
}

detect_local_mode() {
    local script_dir="$(dirname "$0")"

    for template in "${AVAILABLE_TEMPLATES[@]}"; do
        if [ -f "${script_dir}/${template}.rb" ] || [ -f "./${template}.rb" ]; then
            echo "true"
            return
        fi
    done

    echo "false"
}

#==============================================================================
# MAIN FUNCTION
#==============================================================================

main() {
    print_header

    # Parse and validate arguments
    local app_name="${1:-}"
    local template_name="${2:-}"

    validate_app_name "$app_name"
    check_rails

    # Detect execution mode
    local is_local
    is_local=$(detect_local_mode)

    if [ "$is_local" = "true" ]; then
        print_info "Local mode detected - using local template files"
    else
        print_info "Remote mode - using templates from GitHub"
    fi

    # Select template
    template_name=$(select_template "$template_name")

    # Get template configuration
    local template_path
    local template_index
    template_path=$(get_template_path "$template_name" "$is_local")
    template_index=$(get_template_index "$template_name")

    print_info "Selected template: $template_name"
    print_info "Template path: $template_path"
    print_info "Creating Rails app: $app_name"

    # Build Rails command
    local rails_flags="--no-rc"
    if [ "$template_index" -ne -1 ]; then
        rails_flags="$rails_flags ${TEMPLATE_FLAGS[$template_index]}"
    else
        print_warning "Template '$template_name' not found in configuration. Using default flags."
        rails_flags="$rails_flags --skip-test --skip-system-test --database=postgresql --devcontainer"
    fi

    # Execute Rails command
    echo ""
    print_info "Running: rails new $app_name -m $template_path $rails_flags"
    echo ""

    if ! rails new "$app_name" -m "$template_path" $rails_flags; then
        echo ""
        print_error "Failed to create Rails app"
        exit 1
    fi
}

#==============================================================================
# SCRIPT ENTRY POINT
#==============================================================================

# Only run main if script is executed directly (not sourced)
if [ "${BASH_SOURCE[0]:-$0}" = "${0}" ]; then
    main "$@"
fi
