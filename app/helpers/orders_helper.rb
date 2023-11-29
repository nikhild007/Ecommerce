module OrdersHelper
    ORDER_STATUS_MESSAGES = {
       "accepted" => "Order Accepted",
       "dispatched" => "Dispatched",
       "cancelled" => "Cancelled",
       "delivered" => "Delivered",
       "returned" => "Return in progress",
       "refunded" => "Refunded"
    }

    ORDER_STATUS = ["accepted","dispatched","delivered","returned","refunded","cancelled"]

    def calculate_price(price,quantity)
        price*quantity
    end

    def calculate_total_order_value(items)
        items.sum { |item| item.quantity * item.product.price }
    end

    def is_returnable?(status)
        if status.nil?
           return true
        end
        
        for index in 0..ORDER_STATUS.length
            if status == ORDER_STATUS[index]
                return index < 2  
            end  
        end
        return true 
    end

    def get_order_message(status)
        ORDER_STATUS_MESSAGES[status]
    end

    def manage_product_quantity(order_items)
        for item in order_items
            item.product.stock_quantity += item.quantity
            item.product.save
        end
    end
end
