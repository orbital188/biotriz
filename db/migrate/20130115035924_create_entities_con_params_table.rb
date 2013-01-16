class CreateEntitiesConParamsTable < ActiveRecord::Migration
  def up
    create_table :entities_con_params, id: false do |t|
      t.integer :entity_id
      t.integer :parameter_id
    end

    add_index :entities_con_params, [:entity_id, :parameter_id]
    add_index :entities_con_params, [:parameter_id, :entity_id]
  end

  def down
    drop_table :entities_con_params
  end
end
