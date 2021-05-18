class CreateAhoyMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :ahoy_messages, id: :uuid do |t|
      t.references :user, polymorphic: true, type: :uuid
      t.text :to_ciphertext
      t.string :to_bidx, index: true
      t.string :mailer
      t.text :subject
      t.datetime :sent_at
    end
  end
end
