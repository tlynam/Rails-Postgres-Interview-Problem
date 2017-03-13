class CategoriesController < ApplicationController
  def index
    @categories = Category.with_display_posts
  end
end
