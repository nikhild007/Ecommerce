class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order, only: %i[ show destroy update]
    
    include Pundit::Authorization
    include OrdersHelper

    def create
        cart_items = current_user.cart.cart_items
        
        @order = Order.new(user: current_user)
        products_to_update = []

        total = calculate_total_order_value(cart_items)
        cart_items.each do |cart_item|
            product = Product.find(cart_item[:product_id])
             if cart_item.quantity > product.stock_quantity
                # If any item's quantity exceeds the stock quantity, cancel the order and throw an error
                @order.destroy
                flash[:error] = "The quantity of #{product.name} exceeds the available stock."
                redirect_to root_path
                return
            end
            product.stock_quantity -= cart_item.quantity
            @order.order_items.build(product: product, quantity: cart_item[:quantity], total: cart_item.quantity * product.price)
            products_to_update << product
        end

        @order.total = total
        @order.status = "accepted"

        if @order.save!
            cart_items.destroy_all
            products_to_update.each(&:save)
            @items = @order.order_items
            redirect_to controller: 'orders', action: 'index'
        else
            flash[:error] = "Order Failed"
            redirect_to controller: 'cart', action: 'index'
        end
    end

    def destroy
        authorize @order, :destroy?
        manage_product_quantity(@order.order_items)
        if @order.destroy!
            flash[:notice] = "Order Deleted Successfully"
            redirect_to controller:"home", action: "index"
        else
            flash[:error] = "Something went wrong while deleting the order"
            redirect_to controller: 'orders', action: 'show'
        end
    end

    def index
        if current_user.has_role?("admin")
            @orders = Order.all
        else
            @orders = current_user.orders
        end
        render 'orders/index'
    end

    def show
        @items = @order.order_items
        render 'orders/show'
    end

    def update
        if params[:status] != "cancelled"
            authorize @order
        end
        @order.status = params[:status]
        @order.save
        redirect_to    
    end

    private
        def set_order
            @order = Order.find(params[:id])
        end
end
