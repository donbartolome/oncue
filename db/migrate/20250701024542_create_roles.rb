class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :allowed_scope_types

      t.timestamps
    end
  end
end
