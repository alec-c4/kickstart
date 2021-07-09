class CreateAnnouncements < ActiveRecord::Migration[6.1]
  def change
    create_table :announcements, id: :uuid do |t|
      t.datetime :published_at
      t.string :announcement_type
      t.string :name
      t.text :description
      t.belongs_to :publisher, null: false, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
