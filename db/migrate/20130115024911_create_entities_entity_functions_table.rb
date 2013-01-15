class CreateEntitiesEntityFunctionsTable < ActiveRecord::Migration
  def up
    create_table :entities_ent_functions, id: false do |t|
      t.integer :entity_id
      t.integer :entity_function_id
    end

    add_index :entities_ent_functions, [:entity_id, :entity_function_id]
    add_index :entities_ent_functions, [:entity_function_id, :entity_id]
  end

  def down
    drop_table :entities_ent_functions
  end
end
