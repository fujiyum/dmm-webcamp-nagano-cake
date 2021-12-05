class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
       @order.order_details.update_all(making_status: "製作待ち") if @order.status == "入金確認"
       redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :payment, :status, :postage_method, :total_price)
  end

end
