class Post < ApplicationRecord
  has_and_belongs_to_many :categories

  scope :published, -> {
    where("published_at <= ?", Date.current)
  }
end
