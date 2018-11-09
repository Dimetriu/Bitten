class CreateVisits < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :visits, id: :uuid do |t|
      t.string :country, default: "", null: false
      t.string :ipaddr,  degault: "", null: false
      t.references :url, index: { algorithm: :concurrently }

      t.timestamps
    end

    add_index :visits, :country, algorithm: :concurrently
  end
end
