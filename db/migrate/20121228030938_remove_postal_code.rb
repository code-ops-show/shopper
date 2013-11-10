class RemovePostalCode < ActiveRecord::Migration
  def change
    remove_column :addresses, :postal_code
  end
end
