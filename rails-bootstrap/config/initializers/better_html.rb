BetterHtml.configure do |config|
  config.allow_single_quoted_attributes = false
  config.allow_unquoted_attributes = false
  config.partial_tag_name_pattern = /\A[a-zA-Z0-9\-\:]+\z/
end
