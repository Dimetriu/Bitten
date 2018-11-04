class CreateUrls < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :urls, id: :uuid do |t|
      t.string :body,           default: "", null: false
      t.string :shortened_body, default: "", null: false
      t.references :user, foreign_key: true, index: { algorithm: :concurrently }

      t.timestamps
    end

    add_index :urls, [:shortened_body], unique: true, algorithm: :concurrently
  end
end
