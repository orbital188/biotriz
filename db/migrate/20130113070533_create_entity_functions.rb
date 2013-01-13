class CreateEntityFunctions < ActiveRecord::Migration
  def self.up
    create_table :entity_functions do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.string :ancestry
      t.timestamps
    end

    add_index :entity_functions, :ancestry
    add_index :entity_functions, [:ancestry, :title], unique: true
  end

  def self.down
    drop_table :entity_functions
  end
end
