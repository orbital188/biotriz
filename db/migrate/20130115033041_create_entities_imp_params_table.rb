class CreateEntitiesImpParamsTable < ActiveRecord::Migration
  def up
    create_table :entities_imp_params, id: false do |t|
      t.integer :entity_id
      t.integer :parameter_id
    end

    add_index :entities_imp_params, [:entity_id, :parameter_id]
    add_index :entities_imp_params, [:parameter_id, :entity_id]
  end

  def down
    drop_table :entities_imp_params
  end
end
