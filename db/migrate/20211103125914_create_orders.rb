class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.string :address
      t.integer :payment
      t.integer :status
      t.integer :postage_method
      t.integer :total_price

      t.timestamps
    end
  end
end
