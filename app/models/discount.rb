class Discount < ApplicationRecord
  belongs_to :item
  has_many :discount_conditions
end
