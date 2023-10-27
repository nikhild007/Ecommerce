module OrdersHelper
    ORDER_STATUS_MESSAGES = {
       "accepted" => "Order Accepted",
       "dispatched" => "Dispatched",
       "cancel" => "Cancelled",
       "delivered" => "Delivered",
       "return" => "Return in progress",
       "refund" => "Refunded"
    }

    ORDER_STATUS = ["accepted","dispatched","delivered","return","refund","cancel"]

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

end
