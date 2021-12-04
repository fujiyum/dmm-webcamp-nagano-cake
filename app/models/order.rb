class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  enum payment: { credit_card: 0, bank: 1 } #0クレジット払い1銀行振込

  enum status: { waiting: 0, confirmation: 1, production: 2, ready: 3, sent: 4 }#0入金待ち,1入金確認,2製作中,3発送準備中,5発送済み

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

end
