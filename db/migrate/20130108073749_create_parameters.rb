class CreateParameters < ActiveRecord::Migration
  def self.up
    create_table :parameters do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.string :ancestry
      t.timestamps
    end

    add_index :parameters, :ancestry
  end

  def self.down
    remove_index :parameters, :ancestry

    drop_table :parameters
  end
end
