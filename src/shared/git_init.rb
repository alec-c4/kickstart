def init_git_repo
  return if ARGV.include?("--skip-git")

  unless system("git init")
    puts "Failed to initialize git repository"
    exit 1
  end

  system("git add .")
  system('git commit -m "Initial commit"')
end
