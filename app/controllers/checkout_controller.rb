class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def index
    session[:cart] ||= {}

    if session[:cart].empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end

    if current_customer.province.nil?
      redirect_to root_path, alert: "Please add a province to your account before checkout."
      return
    end

    @cart = session[:cart]
    @products = Product.where(id: @cart.keys)

    calculate_totals
  end

  def create
    session[:cart] ||= {}

    if session[:cart].empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end

    province = current_customer.province
    cart = session[:cart]
    products = Product.where(id: cart.keys)

    subtotal = products.sum do |product|
      product.price * cart[product.id.to_s].to_i
    end

    gst = subtotal * (province.gst / 100)
    pst = subtotal * (province.pst / 100)
    hst = subtotal * (province.hst / 100)

    total = subtotal + gst + pst + hst

    order = nil

    ActiveRecord::Base.transaction do
      order = current_customer.orders.create!(
        subtotal: subtotal,
        gst: gst,
        pst: pst,
        hst: hst,
        total: total,
        status: "new"
      )

      products.each do |product|
        order.order_items.create!(
          product: product,
          quantity: cart[product.id.to_s].to_i,
          unit_price: product.price
        )
      end
    end

    session[:cart] = {}

    redirect_to root_path,
                notice: "Thank you for your order! Order ##{order.id} was placed successfully."
  end

  private

  def calculate_totals
    @subtotal = @products.sum do |product|
      product.price * @cart[product.id.to_s].to_i
    end

    province = current_customer.province

    @gst = @subtotal * (province.gst / 100)
    @pst = @subtotal * (province.pst / 100)
    @hst = @subtotal * (province.hst / 100)

    @total = @subtotal + @gst + @pst + @hst
  end
end
