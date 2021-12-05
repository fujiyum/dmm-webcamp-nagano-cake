class Admin::OrderDetailsController < ApplicationController
 before_action :authenticate_admin!

  def update
   @order_detail = OrderDetail.find(params[:id])
   @order = @order_detail.order
   @order_details = @order.order_details
   @order_detail.update(order_detail_params)
   if @order_detail.making_status == "make"
      @order.update(status: :production)
   end

   if @order.order_details.count == @order_details.where(making_status: "completed").count
      @order.status = "ready"
      @order.save
   end
   redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  def order_detail_params
   params.require(:order_detail).permit(:order_id, :item_id, :quantity, :tax_included_price, :making_status)
  end

end
