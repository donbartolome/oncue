class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :address_line1, null: false
      t.string :address_line2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false

      t.timestamps
    end
    add_index :organizations, :type
    add_index :organizations, [ :name, :city, :state ], unique: true
  end
end
