class AddColumnsToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :size_id, :integer
    add_column :entities, :complexity_id, :integer
  end
end
