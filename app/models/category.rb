class Category < ApplicationRecord
  has_and_belongs_to_many :posts

  scope :with_uniq_ready_posts, -> {
    select("DISTINCT ON (posts.id) categories.*, posts.*")
    .includes(:posts)
    .references(:posts)
    .where("posts.published_at <= ?", Date.current)
  }

  def display_posts
    posts.sort_by(&:published_at).reverse.take(4)
  end
end
