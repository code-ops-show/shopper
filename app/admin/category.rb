ActiveAdmin.register Category do

  action_item do
    link_to "New product", new_admin_category_product_path(category) if action_name == 'show'
  end

  before_filter :only => [:show, :edit, :update, :destroy] do
    @category = Category.where(slug: params[:id]).first!
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
      row "Cover" do |course|
        image_tag(category.cover, { size: '150x100' })
      end
    end

    panel "Product" do 
      table_for category.products do
        column "Cover" do |product|
          image_tag(product.cover, { size: '50x50' })
        end
        column "Name" do |product|
          link_to product.name, admin_category_product_path(category, product)
        end
        column "Description" do |product| 
          truncate(product.description, length: 400)
        end
        column :quantity
        column :price
      end
    end
  end

  form partial: 'form'
end
