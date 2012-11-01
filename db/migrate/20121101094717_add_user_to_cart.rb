class AddUserToCart < ActiveRecord::Migration
  def change
    add_column :carts, :user_id, :integer
  end
end
