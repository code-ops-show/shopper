class AddDefaultToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :default, :boolean
  end
end
