class CheckoutController < ApplicationController
  def index
  end

  def create
    session[:cart] = {}

    redirect_to root_path, notice: "Thank you! Your order has been placed."
  end
end
