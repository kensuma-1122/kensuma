module RequestOrdersHelper
  def request_orders_tree_for(request_orders)
    request_orders.map do |request_order, nested_request_orders|
      render(request_order) +
          (nested_request_orders.size > 0 ? content_tag(:div, request_orders_tree_for(nested_request_orders), class: "replies") : nil)
    end.join.html_safe
  end
end
