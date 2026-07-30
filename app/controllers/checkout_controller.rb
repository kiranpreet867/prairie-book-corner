class CheckoutController < ApplicationController
  def index
  end

  def create
    session[:cart] = {}

    flash[:notice] = "Thank you for your order!"
  redirect_to root_path
  end
end
