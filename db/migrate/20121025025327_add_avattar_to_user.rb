class AddAvattarToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :bio, :text
  end
end
