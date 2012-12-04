module CategoriesHelper
  def render_cover_for category
    image_cover = category.cover.present? ? image_tag(category.cover_url(:thumb), {size: '300x200'}) : image_tag('http://placehold.it/300x200', class: 'thumb')
    link = link_to(image_cover, category_products_path(category), class: 'thumb')

    "<div class='cover'>#{link}</div>".html_safe
  end
end