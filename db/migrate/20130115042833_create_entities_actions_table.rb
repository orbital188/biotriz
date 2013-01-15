class CreateEntitiesActionsTable < ActiveRecord::Migration
  def up
    create_table :entities_actions, id: false do |t|
      t.integer :entity_id
      t.integer :action_id
    end

    add_index :entities_actions, [:entity_id, :action_id]
    add_index :entities_actions, [:action_id, :entity_id]
  end

  def down
    drop_table :entities_actions
  end
end
