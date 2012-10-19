class RenameCategoryTable < ActiveRecord::Migration
  def change
    rename_table :categoty, :categories
  end
end
