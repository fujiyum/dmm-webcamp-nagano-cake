class ChangePostageMethodOfOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :postage_method, :string, default: 800
  end
end
