class OrderPolicy < ApplicationPolicy
  attr_reader :user, :order

  def initialize(user,order)
        @user = user
        @order = order
  end

  def create?
    user.has_role?("admin")
  end

  def destroy?
    user.has_role?("admin")
  end

  def update?
    user.has_role?("admin")
  end

  def get?
    user.has_role?("admin")
  end
end
