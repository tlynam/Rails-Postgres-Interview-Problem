require "rails_helper"

describe "categories", type: :feature do
  let!(:post1)     { Post.create!(published_at: Date.current,
                                  title: "Design Your Apartment",
                                  body: "Design your apartment the easy way") }
  let!(:post2)     { Post.create!(published_at: Date.current - 2) }
  let!(:post3)     { Post.create!(published_at: Date.current) }
  let!(:post4)     { Post.create!(published_at: Date.current) }
  let!(:category1) { Category.create!(title: "Apartments", posts: [post1, post2]) }
  let!(:category2) { Category.create!(posts: [post3, post4]) }

  before do
    visit root_path
  end

  it "displays all categories" do
    within(".container-fluid") do
      expect(page).to have_css(".category-row", count: 2)
    end

    within(first(".category-title")) do
      expect(page).to have_content "Apartments"
    end
  end

  it "displays the posts for a category" do
    within(first(".category-row")) do
      expect(page).to have_css(".post-title", count: 2)
      expect(page).to have_css(".post-body", count: 2)

      within(first(".post-title")) do
        expect(page).to have_content "Design Your Apartment"
      end

      within(first(".post-body")) do
        expect(page).to have_content "Design your apartment the easy way"
      end
    end
  end
end
