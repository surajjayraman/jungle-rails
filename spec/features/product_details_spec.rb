require 'rails_helper'

RSpec.feature "Visitor navigates from home page to the product detail page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "clicks on Details button" do
    # goes to home page
    visit root_path
    save_screenshot 'test2a.png'
    expect(page).to have_css 'article.product', count: 10

    # clicks on Details button, wait for load, verify page
    click_link("Details", match: :first)
    sleep(1)
    save_screenshot 'test2b.png'
  end

  scenario "clicks on product's header" do
    # goes to home page
    visit root_path
    expect(page).to have_css 'article.product', count: 10

    # clicks on article header (product image), wait for load, verify page
    find('article.product header', match: :first).click
    sleep(1)
    save_screenshot 'test3.png'
  end


end
