class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: %i[ show destroy update]
    
    include Pundit::Authorization
    include OrdersHelper

    def create
        cart_items = current_user.cart.cart_items
        
        @order = Order.new(user: current_user)
        total = calculate_total_order_value(cart_items)
        cart_items.each do |cart_item|
            product = Product.find(cart_item[:product_id])
            @order.order_items.build(product: product, quantity: cart_item[:quantity], total: cart_item.quantity * product.price)
        end

        @order.total = total

        if @order.save
            cart_items.destroy_all
            @items = @order.order_items
            redirect_to controller: 'orders', action: 'index'
        else
            flash[:error] = "Order Failed"
            redirect_to controller: 'cart', action: 'index'
        end
    end

    def destroy
        authorize @order, :destroy?
        if @order.destroy!
            flash[:notice] = "Order Deleted Successfully"
            redirect_to controller:"home", action: "index"
        else
            flash[:error] = "Something went wrong while deleting the order"
            redirect_to controller: 'orders', action: 'show'
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

    def update
        @order.status = params[:status]
        @order.save
        redirect_to    
    end

    private
        def set_order
            @order = Order.find(params[:id])
        end
end
