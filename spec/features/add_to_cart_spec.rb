require 'rails_helper'

RSpec.feature "Visitor adds product to cart", type: :feature, js: true do
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

  scenario "clicks on Add button and updates cart" do
    # goes to home page
    visit root_path
    save_screenshot 'test4a.png'
    expect(page).to have_content('My Cart (0)')

    # clicks on Add button, wait for load, verify cart
    click_on("Add", match: :first)
    sleep(1)
    save_screenshot 'test4b.png'
    expect(page).to have_content('My Cart (1)')

  end
end
