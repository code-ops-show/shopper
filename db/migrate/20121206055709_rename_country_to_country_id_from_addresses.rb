class RenameCountryToCountryIdFromAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :country, :country_id
  end
end
