class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: %i[ show ]

    def create
        cart_items = current_user.cart.cart_items
        
        order = Order.new(user: current_user)
        total = 0
        cart_items.each do |cart_item|
            product = Product.find(cart_item[:product_id])
            total += cart_item.quantity * product.price
            order.order_items.build(product: product, quantity: cart_item[:quantity],total: cart_item.quantity * product.price)
        end

        order.total = total

        if order.save
            cart_items.destroy_all
            @items = order.order_items
            render 'orders/show'
        else
            render 'cart/index', status: :unprocessable_entity
        end
    end

    def index
        @orders = current_user.orders
        render 'orders/index'
    end

    def show
        @items = @order.order_items
        render 'orders/show'
    end

    private
        def set_order
            @order = Order.find(params[:id])
        end
end
