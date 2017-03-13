require "rails_helper"

RSpec.describe Assignment, type: :model do
  let!(:post1) { Post.create!(published_at: Date.current) }
  let!(:post2) { Post.create!(published_at: Date.current - 9) }
  let!(:post3) { Post.create!(published_at: Date.current - 10) }
  let!(:post4) { Post.create!(published_at: Date.current - 11) }
  let!(:post5) { Post.create!(published_at: Date.current - 12) }
  let!(:post6) { Post.create!(published_at: Date.current - 13) }
  let!(:post7) { Post.create!(published_at: Date.current - 14) }
  let!(:post8) { Post.create!(published_at: Date.current - 15) }
  let!(:post9) { Post.create!(published_at: Date.current + 10) }

  let!(:category1) { Category.create! }
  let!(:category2) { Category.create! }

  let!(:assignment1) { Assignment.create!(post: post1, category: category1) }
  let!(:assignment2) { Assignment.create!(post: post1, category: category2) }
  let!(:assignment3) { Assignment.create!(post: post2, category: category2) }
  let!(:assignment4) { Assignment.create!(post: post3, category: category2) }
  let!(:assignment5) { Assignment.create!(post: post4, category: category2) }
  let!(:assignment6) { Assignment.create!(post: post5, category: category2) }
  let!(:assignment7) { Assignment.new(post: post9, category: category1).save(validate: false) }

  context "scopes" do
    describe "uniq_published_posts" do
      it "returns assignments that contain only unique published posts" do
        assignment_attrs = Assignment.uniq_published_posts.map { |a| { "category_id" => a.category_id, "post_id" => a.post_id } }
        guaranteed_matches = [assignment3.attributes, assignment4.attributes,
                              assignment5.attributes, assignment6.attributes]

        expect(assignment_attrs.size).to eq 5
        expect(assignment_attrs).to include(*guaranteed_matches)

        distinct_on_xor_match = assignment_attrs.include?(assignment1.attributes) ^ assignment_attrs.include?(assignment2.attributes)
        expect(distinct_on_xor_match).to be_truthy
      end
    end

    describe "for_display" do
      it "returns assignments limited by 4 posts per category" do
        assignment_attrs = Assignment.for_display.map { |a| { "category_id" => a.category_id, "post_id" => a.post_id } }
        guaranteed_matches = [assignment3.attributes, assignment4.attributes,
                             assignment5.attributes]

        expect(assignment_attrs).to include(*guaranteed_matches)

        distinct_on_xor_match = assignment_attrs.include?(assignment1.attributes) ^ assignment_attrs.include?(assignment2.attributes)
        expect(distinct_on_xor_match).to be_truthy
      end

      it "returns assignments with posts ordered by published_at" do
        dates = Assignment.for_display.map { |a| a.post.published_at }

        expect(dates).to eq [Date.current, Date.current - 9, Date.current - 10, Date.current - 11, Date.current - 12]
      end
    end
  end
end
