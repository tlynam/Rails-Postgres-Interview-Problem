class CategoriesController < ApplicationController
  def index
    @categories = Category.with_uniq_ready_posts
  end
end
