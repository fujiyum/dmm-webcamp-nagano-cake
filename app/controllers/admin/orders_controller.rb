class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if @order.status == "confirmation"
       @order_details.each do |order_detail|
         order_detail.update(making_status: :wait)
       end
    end
      redirect_to admin_order_path(@order.id)
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :payment, :status, :postage_method, :total_price)
  end

end
