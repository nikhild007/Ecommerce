class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart

  ROLES = {
    "admin" => "ADMIN",
    "user" => "USER"
  }

  def has_role?(role)
    mapped_role = ROLES[role]
    return false if mapped_role.nil? # Invalid role provided

    self.role == mapped_role
  end
end
