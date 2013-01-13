class CreateEntities < ActiveRecord::Migration
  def self.up
    create_table :entities do |t|
      t.string :title, limits: 250, null: false
      t.text :description
      t.string :ancestry
      t.timestamps
    end

    add_index :entities, :ancestry
    add_index :entities, [:ancestry, :title], uniqueness: true
  end

  def self.down
    drop_table :entities
  end
end
