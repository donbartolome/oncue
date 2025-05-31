class CreateStudios < ActiveRecord::Migration[8.0]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
