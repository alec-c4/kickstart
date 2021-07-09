class CreateIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :identities, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""

      t.timestamps
    end

    add_index :identities, %i[uid provider], unique: true
  end
end
