module CartHelper
    def cart_items
        current_user.cart.cart_items.length
    end
end
