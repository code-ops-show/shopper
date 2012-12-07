ActiveAdmin.register ShippingRate do
  action_item do
    link_to "Add country", new_admin_shipping_rate_country_path(shipping_rate) if action_name == 'show'
  end

   index do
    column :name
    column :rate
    default_actions
  end

  show title: :name do 
    attributes_table do 
      row :name
      row :rate
    end

    panel "Countries" do 
      table_for shipping_rate.countries do
        column :name do |country|
          link_to country.name, admin_shipping_rate_country_path(shipping_rate, country)
        end
      end
    end
  end

  form partial: 'form'
end