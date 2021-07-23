class EnableTrgmPsqlExtension < ActiveRecord::Migration[6.1]
  def change
    enable_extension "unaccent"
    enable_extension "pg_trgm"
    enable_extension "fuzzystrmatch"
  end
end
