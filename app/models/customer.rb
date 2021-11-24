class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :orders, dependent: :destroy
 has_many :addresses, dependent: :destroy
 has_many :cart_items, dependent: :destroy

 validates :last_name, presence: true
 validates :first_name, presence: true
 validates :last_name_kana, presence: true
 validates :first_name_kana, presence: true
 validates :postal_code, presence: true
 validates :address, presence: true
 validates :telephone_number, presence: true
 validates :email, presence: true


  def full_name
    self.last_name + self.first_name
  end

  def full_name_kana
    self.last_name_kana + self.first_name_kana
  end

  enum is_active: {"有効": true, "退会": false}
  validates :is_active, inclusion: {in: ["有効", "退会"]}

  def active_for_authentication? #退会済み顧客が同じアカウントでログインできないようにする
    super && (is_active == "有効")
  end

end
