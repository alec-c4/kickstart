class EnableTrgmPsqlExtension < ActiveRecord::Migration[6.0]
  def change
    enable_extension "unaccent"
    enable_extension "pg_trgm"
    enable_extension "fuzzystrmatch"
  end
end
