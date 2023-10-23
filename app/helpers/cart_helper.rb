module CartHelper
    def cart_items
        current_user&.cart&.cart_items&.length || 0
    end
end
