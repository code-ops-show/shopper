class RemoveEmailFormAddress < ActiveRecord::Migration
  def change
    remove_column :addresses, :email
  end
end
