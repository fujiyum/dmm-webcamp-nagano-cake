class CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def update#数量の変更
    @cart_items = current_customer.cart_items
    @cart_items.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy#1つの商品を削除
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def enpty#カート内の商品を全て削除
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       redirect_to cart_items_path
    else
       @cart_item.save
       redirect_to cart_items_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
