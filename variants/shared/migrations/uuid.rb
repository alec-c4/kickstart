class EnableUuidPsqlExtension < ActiveRecord::Migration[8.1]
  def change
    enable_extension "pgcrypto"
    enable_extension "uuid-ossp"
  end
end
