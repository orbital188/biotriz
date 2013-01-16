class CreateEntitiesEnvironmentsTable < ActiveRecord::Migration
  def up
    create_table :entities_environments, id: false do |t|
      t.integer :entity_id
      t.integer :environment_id
    end

    add_index :entities_environments, [:entity_id, :environment_id]
    add_index :entities_environments, [:environment_id, :entity_id]
  end

  def down
    drop_table :entities_environments
  end
end
