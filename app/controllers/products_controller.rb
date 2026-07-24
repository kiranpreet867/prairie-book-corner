class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).order(:name)
  end

  def show
    @product = Product.find(params[:id])
  end
end
