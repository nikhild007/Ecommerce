class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :orders

  ROLES = {
    "admin" => "ADMIN",
    "customer" => "CUSTOMER"
  }

  def has_role?(role)
    self.role == ROLES[role]
  end
end
