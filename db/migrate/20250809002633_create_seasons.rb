class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.integer :start_year
      t.integer :end_year
      t.references :studio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
