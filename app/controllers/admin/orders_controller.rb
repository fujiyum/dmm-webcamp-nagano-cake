class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :payment, :status, :postage_method, :total_price)
  end

end
