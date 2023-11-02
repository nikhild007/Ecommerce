class UpdateOrderStatusJob
  include Sidekiq::Job

  def perform(order_id,order_status)
    order = Order.find(order_id)
    order.update(status: order_status)
  end
end
