require "rails_helper"

RSpec.describe Post, type: :model do
  context "scopes" do
    describe "published" do
      it "returns posts published today or previously" do
        post1 = Post.create!(published_at: Date.current - 11)
        post2 = Post.create!(published_at: Date.current)
                Post.create!(published_at: Date.current + 22)

        expect(Post.published).to match_array [post1, post2]
      end
    end
  end
end
