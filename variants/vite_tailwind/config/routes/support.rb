get "up", to: "rails/health#show", as: :rails_health_check

# Render dynamic PWA files from app/views/pwa/*
get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
