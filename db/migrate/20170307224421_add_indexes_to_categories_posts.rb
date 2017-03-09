class AddIndexesToCategoriesPosts < ActiveRecord::Migration[5.0]
  def change
    add_index(:categories_posts, [:category_id, :post_id])
  end
end
