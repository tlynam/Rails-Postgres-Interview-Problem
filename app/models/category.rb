class Category < ApplicationRecord
  attr_accessor :display_posts

  has_and_belongs_to_many :posts

  scope :ordered, -> {
    order(:title)
  }

  def self.with_display_posts
    display_assignments = Assignment.for_display_grouped

    ordered.each do |cat|
      cat.display_posts = display_assignments[cat.id]&.map(&:post) || []
    end
  end
end
