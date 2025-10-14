copy_file "config/settings/aws_config.rb", force: true
copy_file "config/aws.yml", force: true

initializer "shrine.rb", <<-CODE
  require "shrine"
  require "shrine/storage/file_system"
  require "shrine/storage/memory"
  require "shrine/storage/s3"

  Shrine.plugin :activerecord
  Shrine.plugin :backgrounding
  Shrine.plugin :cached_attachment_data
  Shrine.plugin :derivatives
  Shrine.plugin :determine_mime_type, analyzer: :marcel
  Shrine.plugin :download_endpoint, prefix: "downloads"
  Shrine.plugin :instrumentation, notifications: ActiveSupport::Notifications unless Rails.env.test?
  Shrine.plugin :pretty_location
  Shrine.plugin :remove_attachment
  Shrine.plugin :restore_cached_data
  Shrine.plugin :store_dimensions, analyzer: :fastimage
  Shrine.plugin :validation
  Shrine.plugin :validation_helpers

  ### Storages
  s3_options = {
    access_key_id: AwsConfig.access_key_id,
    secret_access_key: AwsConfig.secret_access_key,
    region: AwsConfig.s3_region,
    bucket: AwsConfig.s3_bucket
  }

  Shrine.storages =
    if Rails.env.production?
      {
        cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
        store: Shrine::Storage::S3.new(prefix: "store", **s3_options)
      }
    elsif Rails.env.test?
      {
        cache: Shrine::Storage::Memory.new,
        store: Shrine::Storage::Memory.new
      }
    else # development and staging
      {
        cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
        store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
      }
    end

  ### Backgrounding
  Shrine::Attacher.promote_block do
    job_class = Shrine::PromoteAttachmentJob

    if Rails.env.production?
      job_class.perform_later(self.class.name, record.class.name, record.id, name, file_data)
    else
      job_class.perform_now(self.class.name, record.class.name, record.id, name, file_data)
    end
  end

  Shrine::Attacher.destroy_block do
    job_class = Shrine::DestroyAttachmentJob

    if Rails.env.production?
      job_class.perform_later(self.class.name, data)
    else
      job_class.perform_now(self.class.name, data)
    end
  end
CODE

directory "app/uploaders", force: true
