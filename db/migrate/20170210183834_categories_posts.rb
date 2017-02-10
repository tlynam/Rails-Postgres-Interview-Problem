class CategoriesPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_posts, id: false do |t|
      t.integer :category_id, null: false
      t.integer :post_id, null: false
    end

    add_foreign_key :categories_posts, :categories
    add_foreign_key :categories_posts, :posts
  end
end
