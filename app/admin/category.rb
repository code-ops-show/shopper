ActiveAdmin.register Category do
  action_item do
    link_to "Add product", new_admin_category_product_path(category) if action_name == 'show'
  end
  
  index do
    column :name
    column :description
    default_actions
  end

  show title: :name do 
    attributes_table do 
      row :name
      row :description
    end

    panel "Product" do 
      table_for category.products do 
        column :name
        column :description
      end
    end
  end

  form partial: 'form'
end
