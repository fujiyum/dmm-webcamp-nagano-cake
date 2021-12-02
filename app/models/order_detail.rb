class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { start: 0, wait: 1, make: 2, completed: 3 }

end
