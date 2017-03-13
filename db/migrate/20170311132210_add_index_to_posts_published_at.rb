class AddIndexToPostsPublishedAt < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :published_at
  end
end
