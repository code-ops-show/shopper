ActiveAdmin.register Product do
  belongs_to :category

  show title: :name do 
    attributes_table do 
      row :name
      row :description
      row :quantity
      row :price
      row "Cover" do |course|
        image_tag(category.cover, { size: '300x200', crop: 'fill' })
      end
    end
  end
end