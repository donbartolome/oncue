class CreateStudioMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :studio_memberships do |t|
      t.references :studio, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :studio_memberships, [ :studio_id, :person_id, :role ], unique: true
  end
end
