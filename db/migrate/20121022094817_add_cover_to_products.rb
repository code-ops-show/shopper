class AddCoverToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cover, :string
  end
end
