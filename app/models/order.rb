class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: {
       "accepted" => "Order Accepted",
       "dispatched" => "Dispatched",
       "cancelled" => "Cancelled",
       "delivered" => "Delivered",
       "returned" => "Return in progress",
       "refunded" => "Refunded"
  }
end
