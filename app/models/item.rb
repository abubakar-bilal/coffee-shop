class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  def price_with_tax
    self.price + (self.price * (self.tax_rate / 100))
  end
end
