class HomesController < ApplicationController

  def top
    @item = Item.page(params[:page]).per(4).reverse_order
  end

  def about
  end

end
