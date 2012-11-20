class AddUserToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :user_id, :integer
  end
end
