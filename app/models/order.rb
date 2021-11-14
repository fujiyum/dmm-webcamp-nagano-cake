class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  enum payment: { credit_card: 0, bank: 1} #0クレジット払い1銀行振込

end
