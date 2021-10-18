require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation test/examples here

    it 'is valid with the 4 parameters listed' do
      @category = Category.new()
      @product = Product.new(name: 'Dog', price: 2000, quantity: 1, category: @category)
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @category = Category.new()
      @product = Product.new(name: nil , price: 2000, quantity: 1, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).to_not be_valid
    end

    it 'is not valid without a price' do
      @category = Category.new()
      @product = Product.new(name: 'Dog' , price: nil, quantity: 1, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      @category = Category.new()
      @product = Product.new(name: 'Dog' , price: 2000, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid
    end

    it 'is not valid without a category' do
      @product = Product.new(name: 'Dog' , price: 2000, quantity: 1, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end

  end
end