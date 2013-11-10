class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
  end
end
