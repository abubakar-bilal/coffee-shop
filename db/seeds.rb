# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


ActiveRecord::Base.transaction do
  if User.count.zero?
    user1 = User.create(email: 'mark@example.com', password: 'password123')
    user2 = User.create(email: 'abu@example.com', password: 'password456')
  end

  if Item.count.zero?
    item1 = Item.create(name: 'Coffee', price: 3.0, tax_rate: 10)
    item2 = Item.create(name: 'Sandwich', price: 5.0, tax_rate: 10)
    item3 = Item.create(name: 'Cold Drink Pepsi', price: 2.0, tax_rate: 5)

    Order.create(user: user1, status: 'completed', order_items: [OrderItem.new(item: item1, quantity: 2),
                                                                OrderItem.new(item: item2, quantity: 1)])
    Order.create(user: user2, order_items: [OrderItem.new(item: item2, quantity: 3),
                                            OrderItem.new(item: item3, quantity: 2)])
    Order.create(user: user1, order_items: [OrderItem.new(item: item1, quantity: 2)])
    Order.create(user: user2, order_items: [OrderItem.new(item: item3, quantity: 3)])

    discount = Discount.create!(
      name: "20% off Coffee if Sandwich purchased",
      item_id: 1,  # Coffee is discounted
      discount_rate: 20.0
    )

    DiscountCondition.create!(
      discount_id: discount.id,
      item_id: 2  # Item Sandwich
    )

    discount = Discount.create!(
      name: "50% off Coffee if Sandwich and Cold Drink purchased",
      item_id: 1,  # Coffee is discounted
      discount_rate: 50.0
    )

    DiscountCondition.create!(
      discount_id: discount.id,
      item_id: 2  # Item Sandwich
    )

    DiscountCondition.create!(
      discount_id: discount.id,
      item_id: 3  # Item Cold Drink
    )
  end
end
