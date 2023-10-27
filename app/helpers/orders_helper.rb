module OrdersHelper
    def calculate_price(price,quantity)
        price*quantity
    end

    def calculate_total_order_value(items)
        total = 0
        for item in items
            total += item.quantity * item.product.price
        end
        return total
    end
end
