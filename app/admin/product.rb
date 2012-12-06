ActiveAdmin.register Product do
  belongs_to :category

  show title: :name do 
    attributes_table do 
      row :name
      row :description
      row :quantity
      row :price
      row "Cover" do |product|
        image_tag(product.cover.thumb)
      end
    end
  end
end