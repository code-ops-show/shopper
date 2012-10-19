class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categoty do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
