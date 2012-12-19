class CreateSizes < ActiveRecord::Migration
  def self.up
    create_table :sizes do |t|
      t.string :title, limit: 250
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :sizes
  end
end
