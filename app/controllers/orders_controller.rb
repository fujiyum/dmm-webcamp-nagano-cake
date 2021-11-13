class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new
    @cart_items = current_customer.cart_items
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end
end
