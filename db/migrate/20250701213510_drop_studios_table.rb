class DropStudiosTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :studios
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "This migration cannot be reverted because it destroys data."
  end
end
