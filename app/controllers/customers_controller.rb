class CustomersController < ApplicationController
  before_action :authenticate_customer! #URLの直打ち禁止

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false) #false=退会に変更する
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用お待ちしております。"
    redirect_to homes_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name,:last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end

end