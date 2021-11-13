class Address < ApplicationRecord

  belongs_to :customer

  def full_address
    '〒' + postal_cade + '' + address + '' + name
  end

end
