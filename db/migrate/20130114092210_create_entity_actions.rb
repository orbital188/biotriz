class CreateEntityActions < ActiveRecord::Migration
  def self.up
    create_table :entity_actions do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.string :ancestry
      t.timestamps
    end

    add_index :entity_actions, :ancestry
    add_index :entity_actions, [:ancestry, :title], unique: true
  end

  def self.down
    drop_table :entity_actions
  end
end
