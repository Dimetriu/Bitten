class CreateUsers < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :users do |t|
      t.string :given_name,         default: "", null: false
      t.string :family_name,        default: "", null: false
      t.string :email,              default: "", null: false
      t.string :password_digest,    default: "", null: false
      # t.string :confirmation_token, default: "", null: false

      # t.datetime :confirmed_at

      t.timestamps
    end

    add_index :users, :email, unique: true, algorithm: :concurrently
  end
end
