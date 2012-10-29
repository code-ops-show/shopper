class CreateCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :user, :product
 
      t.timestamps
    end
  end
end
