require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:category) { Category.create!(title: "Apartments") }

  context "scopes" do
    describe "with_uniq_ready_posts" do
      it "returns categories with unique posts" do
        post1 = category.posts.create!(published_at: Date.current - 11)
        post2 = category.posts.create!(published_at: Date.current)

        category2 = Category.create!(title: "Lofts")
        category2.posts = [post1]

        expect(Category.with_uniq_ready_posts).to eq [category]
        expect(Category.with_uniq_ready_posts.to_a.first.posts).to match_array [post1, post2]
      end

      it "returns categories with posts published today or previously" do
        post1 = category.posts.create!(published_at: Date.current - 11)
        post2 = category.posts.create!(published_at: Date.current)
                category.posts.create!(published_at: Date.current + 22)

        expect(Category.with_uniq_ready_posts).to eq [category]
        expect(Category.with_uniq_ready_posts.to_a.first.posts).to match_array [post1, post2]
      end
    end
  end

  describe "#display_posts" do
    it "returns posts sorted by published at descending" do
      post1 = category.posts.create!(published_at: Date.current - 11)
      post2 = category.posts.create!(published_at: Date.current - 2)
      post3 = category.posts.create!(published_at: Date.current - 22)

      expect(category.display_posts).to eq [post2, post1, post3]
    end

    it "returns only 4 posts" do
      10.times { category.posts.create! }
      expect(category.display_posts.size).to eq 4
    end
  end
end
