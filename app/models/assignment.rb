class Assignment < ApplicationRecord
  self.table_name = "categories_posts"
  belongs_to :category
  belongs_to :post
  belongs_to :published_post, -> { published }, class_name: "Post", foreign_key: :post_id

  scope :uniq_published_posts, -> {
    select("DISTINCT ON (posts.id) post_id, category_id, published_at").joins(:published_post)
  }

  scope :for_display, -> {
    window_query = <<-SQL
      category_id, published_at, post_id,
      row_number() OVER (
        PARTITION BY category_id
        ORDER BY published_at DESC
      ) AS row_num
    SQL

    subquery = select(window_query).from("(#{uniq_published_posts.to_sql}) AS UNIQ_SET").order("category_id ASC")

    select("category_id, post_id").includes(:post).from(subquery).where("row_num < 5")
  }

  def self.for_display_grouped
    for_display.to_a.group_by(&:category_id)
  end
end
