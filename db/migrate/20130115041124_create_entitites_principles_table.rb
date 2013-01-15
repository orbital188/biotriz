class CreateEntititesPrinciplesTable < ActiveRecord::Migration
  def up
    create_table :entities_principles, id: false do |t|
      t.integer :entity_id
      t.integer :principle_id
    end

    add_index :entities_principles, [:entity_id, :principle_id]
    add_index :entities_principles, [:principle_id, :entity_id]
  end

  def down
    drop_table :entities_principles
  end
end
