class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
        @user = user
        @product = product
  end

  def create?
    user.has_role?("admin")
  end

  def destroy?
    user.has_role?("admin")
  end
end
