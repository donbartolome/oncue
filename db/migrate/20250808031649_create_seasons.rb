class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.string :name, null: false
      t.integer :start_year, null: false
      t.integer :end_year, null: false
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
