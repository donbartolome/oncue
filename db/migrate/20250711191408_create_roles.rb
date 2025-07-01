class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.references :person, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :roles, [ :person_id, :organization_id, :role ], unique: true
  end
end
