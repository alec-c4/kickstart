inject_into_file ".devcontainer/devcontainer.json", after: /"ghcr.io\/rails\/devcontainer\/features\/activestorage": {},\n/ do
  # the empty line at the beginning of this string is required
  <<-CODE
    "ghcr.io/devcontainers/features/node:1": {
      "installYarnUsingApt": false
    },
  CODE
end
