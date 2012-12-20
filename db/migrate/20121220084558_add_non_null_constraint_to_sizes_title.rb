class AddNonNullConstraintToSizesTitle < ActiveRecord::Migration
  def self.up
    change_column :sizes, :title, :string, limit: 250, null: false
  end

  def self.down
    change_column :sizes, :title, :string, limit: 250, null: true
  end
end
