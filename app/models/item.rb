class Item < ApplicationRecord
  belongs_to :genre

  has_many :order_details, dependent: :destroy

  attachment :image

  def add_tax_price
    (self.price * 1.08).round
  end
end
