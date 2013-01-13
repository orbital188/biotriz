class AddIndicesToTables < ActiveRecord::Migration
  def change
    add_index :sizes, :title, unique: true
    add_index :complexities, :title, unique: true
    add_index :environments, [:ancestry, :title], unique: true
    add_index :parameters, [:ancestry, :title], unique: true
  end
end
