class CreateLoginActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :login_activities, id: :uuid do |t|
      t.string :scope
      t.string :strategy
      t.text :identity_ciphertext
      t.string :identity_bidx, index: true
      t.boolean :success
      t.string :failure_reason
      t.references :user, polymorphic: true, type: :uuid
      t.string :context
      t.text :ip_ciphertext
      t.string :ip_bidx, index: true
      t.text :user_agent
      t.text :referrer
      t.string :city
      t.string :region
      t.string :country
      t.float :latitude
      t.float :longitude
      t.datetime :created_at
    end
  end
end
