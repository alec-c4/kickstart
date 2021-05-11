json.extract! announcement, :id, :published_at, :announcement_type, :name, :description, :created_at, :updated_at
json.url admin_announcement_url(announcement, format: :json)
