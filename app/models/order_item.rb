class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: {only_integer: true}
  def subtotal
    if self.quantity == nil 
      0 
    else 
      self.quantity * self.product.price 
    end
  end
end
