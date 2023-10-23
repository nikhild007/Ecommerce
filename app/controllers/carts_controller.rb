class CartsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_or_create_cart, only: %i[ add_to_cart ]

    def index
        @cart = current_user.cart
        @items = @cart.cart_items.includes(:product)
        render 'cart/index'
    end

    def add_to_cart
        product = Product.find(params[:product_id])
        cart_item = CartItem.find_by(cart_id: @cart.id, product_id: product.id)
        if cart_item
            cart_item.quantity += 1
            cart_item.save
            flash[:notice] = "Item quantity updated."
        else
            new_cart_item = CartItem.new(product_id: product.id,cart_id: @cart.id)
            new_cart_item.save
        end
        redirect_to
    end

    private
        def get_or_create_cart
            @cart = Cart.find_by(user_id: current_user.id)
            if !@cart
                @cart = Cart.new(user_id: current_user.id)
                @cart.cart_items = []
                @cart.save
                @items = []
            else
                @items = @cart.cart_items.includes(:product)
            end
        end
end
