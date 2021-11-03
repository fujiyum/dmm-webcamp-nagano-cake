class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.params([:id])
  end

  def edit
  end

  def update
  end

  private
  def customer_params
    params.require(:customer).permit(:customer_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :postale_code, :address, :telephone_number, :email, :is_active)
  end

end
