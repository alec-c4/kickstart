# Uncomment the RuboCop autocorrection line in development.rb
gsub_file "config/environments/development.rb",
          "# config.generators.apply_rubocop_autocorrect_after_generate!",
          "config.generators.apply_rubocop_autocorrect_after_generate!"
