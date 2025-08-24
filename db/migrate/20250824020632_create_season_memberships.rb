class CreateSeasonMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :season_memberships do |t|
      t.references :season, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
    add_index :season_memberships, [ :season_id, :person_id, :role ], unique: true
  end
end
