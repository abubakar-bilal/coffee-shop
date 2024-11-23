class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  accepts_nested_attributes_for :order_items

  after_update :send_email, if: :completed?
  after_update :schedule_completion, if: :processing?

  enum status: {
    pending: 0,
    processing: 1,
    completed: 2
  }

  def calculate_total
    sub_total = order_items.includes(:item).sum do |order_item|
      order_item.item.price_with_tax * order_item.quantity
    end

    discount = calculate_discount

    self.total = sub_total - discount
  end

  private

  def calculate_discount
    total_discount = 0.0

    Discount.includes(:discount_conditions).find_each do |discount|
      # Check if all trigger conditions are met
      if discount.discount_conditions.all? { |condition| condition_met?(condition) }
        # Find the target item in the order
        target_item = order_items.find_by(item_id: discount.item_id)

        next if target_item.blank?

        # Calculate discount for the target item
        total_discount += (discount.discount_rate / 100.0) * target_item.item.price_with_tax * target_item.quantity
      end
    end

    total_discount
  end

  def condition_met?(condition)
    order_items.find_by(item_id: condition.item_id).present?
  end

  def send_email
    OrderMailer.order_completed(self).deliver_later
  end

  def schedule_completion
    CompleteOrderJob.set(wait: 5.seconds).perform_later(self)
  end
end
