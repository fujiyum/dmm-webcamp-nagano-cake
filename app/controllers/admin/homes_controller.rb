class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer

 def top
   if params[:customer_id] == @customer.ids
    @orders = @customer.orders.all
   else
    @orders = Order.all
   end
 end

 private

 def set_customer
   @customer = Customer.all
 end

end
