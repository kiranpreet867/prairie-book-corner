class CartController < ApplicationController
  def show
    session[:cart] ||= {}

    @cart = session[:cart]
    @products = Product.where(id: @cart.keys)
  end

  def add
    session[:cart] ||= {}

    id = params[:product_id].to_s

    if session[:cart][id]
      session[:cart][id] += 1
    else
      session[:cart][id] = 1
    end

    redirect_to cart_path, notice: "Product added to cart."
  end

  def update
    id = params[:product_id].to_s

    session[:cart][id] = params[:quantity].to_i

    session[:cart].delete(id) if session[:cart][id] <= 0

    redirect_to cart_path, notice: "Cart updated."
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)

    redirect_to cart_path, notice: "Item removed."
  end
end
