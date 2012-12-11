require 'spec_helper'

describe CategoriesHelper do

  let(:category)    { Category.make! }
  describe 'render_cover_for' do
    it "should not return nil" do
      helper.render_cover_for(category).should_not be_nil
    end

    it "should include cover" do
      helper.render_cover_for(category).should include "<div class='cover'><a href=\"/categories/#{category.name}/products\" class=\"thumb\"><img alt=\"300x200\" class=\"thumb\" src=\"http://placehold.it/300x200\" /></a></div>"
    end
  end
end