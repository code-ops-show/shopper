class CreatePurchase < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.integer :price
      t.references :user
      t.timestamps
    end
  end
end
