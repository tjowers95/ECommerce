class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  def total
   total = Float(0) 
   @items = OrderItem.select{|k,v| k['order_id'] = self.id}
   @items.each do |i|
    total += i.subtotal.to_f
   end
   total
  end
end
