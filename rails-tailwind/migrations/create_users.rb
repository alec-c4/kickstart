# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      ## Database authenticatable
      t.text :email_ciphertext, null: false, default: ""
      t.string :email_bidx, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      ## Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.text :unconfirmed_email_ciphertext
      t.string :unconfirmed_email_bidx

      ## Lockable
      t.integer :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Ban
      t.datetime :banned_at
      t.text :ban_reason, null: false, default: ""
      t.references :banned_by, foreign_key: { to_table: :users }, type: :uuid

      ## Profile
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birthday

      ## Referral
      t.string :referral_code
      t.uuid :referred_by_id
      t.datetime :referral_completed_at
      t.integer :referral_clicks, null: false, default: 0
      t.integer :referral_registrations, null: false, default: 0

      ## Settings
      t.string :time_zone
      t.datetime :announcements_last_read_at

      t.timestamps null: false
    end

    add_index :users, :email_bidx, unique: true
    add_index :users, :unconfirmed_email_bidx
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
    add_index :users, :unlock_token, unique: true
    add_index :users, :referral_code, unique: true
  end
end
