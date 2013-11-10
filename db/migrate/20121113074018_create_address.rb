class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.integer :phone
      t.string :email
 
      t.timestamps
    end
  end
end
