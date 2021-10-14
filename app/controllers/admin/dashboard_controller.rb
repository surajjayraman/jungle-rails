class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.sum(:quantity)
    @category_count = Category.count
    @categories = Category.all
  end
end
