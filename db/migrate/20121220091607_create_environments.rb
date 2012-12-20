class CreateEnvironments < ActiveRecord::Migration
  def self.up
    create_table :environments do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.string :ancestry
      t.timestamps
    end

    add_index :environments, :ancestry
  end

  def self.down
    drop_table :environments

    remove_index :environments, :ancestry
  end
end
