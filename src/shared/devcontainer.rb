dc_file = ".devcontainer/devcontainer.json"
if File.exist?(dc_file)
  gsub_file dc_file,
            '"ghcr.io/devcontainers/features/node:1": {},',
            <<-CODE
              "ghcr.io/devcontainers/features/node:1": {
                "installYarnUsingApt": false
              },
            CODE
end
