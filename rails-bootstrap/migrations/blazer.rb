class InstallBlazer < ActiveRecord::Migration[6.1]
  def change
    create_table :blazer_queries, id: :uuid do |t|
      t.references :creator, type: :uuid
      t.string :name
      t.text :description
      t.text :statement
      t.string :data_source
      t.string :status
      t.timestamps null: false
    end

    create_table :blazer_audits, id: :uuid do |t|
      t.references :user, type: :uuid
      t.references :query, type: :uuid
      t.text :statement
      t.string :data_source
      t.datetime :created_at
    end

    create_table :blazer_dashboards, id: :uuid do |t|
      t.references :creator, type: :uuid
      t.string :name
      t.timestamps null: false
    end

    create_table :blazer_dashboard_queries, id: :uuid do |t|
      t.references :dashboard, type: :uuid
      t.references :query, type: :uuid
      t.integer :position
      t.timestamps null: false
    end

    create_table :blazer_checks, id: :uuid do |t|
      t.references :creator, type: :uuid
      t.references :query, type: :uuid
      t.string :state
      t.string :schedule
      t.text :emails
      t.text :slack_channels
      t.string :check_type
      t.text :message
      t.datetime :last_run_at
      t.timestamps null: false
    end
  end
end
