class OrderMailer < ApplicationMailer
  def order_completed(order)
    @order = order
    mail(to: order.user.email, subject: 'Your Order Is Ready')
  end
end
