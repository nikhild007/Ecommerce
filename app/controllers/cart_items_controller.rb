class CartItemsController < ApplicationController
    before_action :authenticate_user!

    def new
    end

    def increment
        product_id = params[:product_id]
        product = Product.find_by(id: product_id)
        cart_item = current_user.cart.cart_items.find_by(product_id: product_id)
        if product.stock_quantity == cart_item.quantity
            @error = `You cannot add more than #{cart_item.quantity}`
        else
            cart_item.quantity += 1;
            cart_item.save
        end
        redirect_to controller: 'carts', action: 'index'
    end

    def decrement
        product_id = params[:product_id]
        product = Product.find_by(id: product_id)
        cart_item = current_user.cart.cart_items.find_by(product_id: product_id)
        cart_item.quantity -= 1;
        if cart_item.quantity == 0
            cart_item.destroy!
        else
            cart_item.save
        end

        redirect_to controller: 'carts', action: 'index'
    end
end
