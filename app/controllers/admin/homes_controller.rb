class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

def top
  if params[:customer_id].blank?
     @orders = Order.all
  else
     @customer = Customer.find(params[:customer_id])
     @orders = @customer.orders
  end
end

end
