class ItemsController < ApplicationController
  def index
    @items = Item.all
    @item_count = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(item_id: @item.id)
  end

  private

  def item_params
    params.require(:item).premit(:name, :image, :introduction, :price)
  end

end
