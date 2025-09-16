initializer "i18n.rb", <<-CODE
  I18n.load_path += Rails.root.glob("config/locales/**/*.{rb,yml}")
  I18n.default_locale = :en
  I18n.available_locales = %i[en ru]
CODE

directory "config/locales", force: true
