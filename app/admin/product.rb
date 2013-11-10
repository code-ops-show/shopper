ActiveAdmin.register Product do
  belongs_to :category

  before_filter do
    @category = Category.where(slug: params[:category_id]).first!
  end

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