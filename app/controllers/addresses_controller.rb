class AddressesController < ApplicationController
  before_action :authenticate_custmer! #URLの直打ち禁止
  before_action :correct_address,only: [:index, :edit]

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.find(params[:id])
    @address.save
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    address = Address.find(params[:id])
    address.update
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
  end

　#URLの直打ち禁止
  def correct_address
       @address = Address.find(params[:id])
    unless @address.customer.id == current_customer.id
      redirect_to homes_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

end
