class CreatePrinciples < ActiveRecord::Migration
  def self.up
    create_table :principles do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.string :ancestry
      t.integer :principle_number
      t.timestamps
    end

    add_index :principles, :title, unique: true
  end

  def self.down
    drop_table :principles
  end
end
