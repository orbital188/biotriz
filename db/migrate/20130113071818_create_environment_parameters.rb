class CreateEnvironmentParameters < ActiveRecord::Migration
  def self.up
    create_table :environment_parameters do |t|
      t.string :title, limit: 250, null: false
      t.text :description
      t.timestamps
    end

    add_index :environment_parameters, :title, unique: true
  end

  def self.down
    drop_table :environment_parameters
  end
end
