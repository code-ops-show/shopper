class ChangeColumnForeignKeyToInteger < ActiveRecord::Migration
  def change
    add_column :addresses, :temp_country_id, :integer

    Address.all.each do |a|
      a.update_attribute :temp_country_id, a.country_id
    end

    remove_column :addresses, :country_id
    rename_column :addresses, :temp_country_id, :country_id
  end
end
