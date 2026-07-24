class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.includes(:category).order(:name)

    if params[:search].present?
      keyword = "%#{Product.sanitize_sql_like(params[:search])}%"

      @products = @products.where(
        "products.name ILIKE :keyword OR products.description ILIKE :keyword",
        keyword: keyword
      )
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    case params[:filter]
    when "sale"
      @products = @products.where(on_sale: true)
    when "new"
      @products = @products.where(created_at: 3.days.ago..Time.current)
    end

    # Pagination MUST be inside the index method
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
