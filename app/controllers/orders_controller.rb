class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
      cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
      if @order.save
          cart_items.each do |cart|
              order_detail = OrderDetail.new
              order_detail.order_id = @order.id
              order_detail.item_id = cart.item_id
              order_detail.quantity = cart.amount
              order_detail.tax_included_price = cart.item.price*1.08
              order_detail.save
          end
          redirect_to order_thanks_path(@order.id)
          cart_items.destroy_all
      else
          @order = Order.new(order_params)
          render :new
      end
  end

  def confirm
    @order = Order.new(order_params)
     if params[:order][:select_address] == "1"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.full_name
     elsif params[:order][:select_address] == "2"
         @address = Address.find(params[:order][:address_id])
         @order.postal_code = @address.postal_code
         @order.address = @address.address
         @order.name = @address.name
     elsif params[:order][:select_address] == "3"
       address_new = current_customer.addresses.new(address_params)
       if address_new.save
       else
         render :new
       end
     end
     @cart_items = current_customer.cart_items.all
     @total_price = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.page(params[:page]).reverse_order.includes(:order_details)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment, :name, :postal_code, :address, :total_price)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :quantity, :tax_included_price, :making_status)
  end

end
