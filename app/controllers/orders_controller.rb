class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    binding.pry
     if params[:order][:select_address_id] == "1"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.full_name
     elsif params[:order][:select_address_id] == "2"
         @address = Address.find(params[:order][:address_id])
         @order.postal_code = @address.postal_code
         @order.address = @address.address
         @order.name = @address.name
     elsif params[:order][:select_address_id] == "3"
       address_new = current_customer.addresses.new(address_params)
       if address_new.save
       else
         render :new
       end
     end
     @cart_items = current_customer.cart_items.all
  end

  def thanks
  end

  def create
      cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
      if @order.save
          cart_items.each do |cart|
              order_item = OrderItem.new
              order_item.item_id = @order.id
              order_item.order_amount = cart.amount
              order_item.order_price = cart.item.price
              order_item.save
          end
          redirect_to order_thanks_path
          cart_items.destroy_all
      else
          @order = Order.new(order_params)
          render :new
      end
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment, :name, :postal_code, :address)
  end

  def address_params
    params.require(:order).permit(:name, :postal_code, :address)
  end

end
