# Finalize layouts after Inertia generator has run
# This ensures we have our custom layout with all necessary tags

say "Finalizing Inertia layouts..."

# Copy our final application layout (with proper Inertia and Vite tags)
copy_file "app/views/layouts/application.html.erb", force: true

say "Layouts finalized with Inertia and Vite configuration"
