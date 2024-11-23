class Api::OrdersController < Api::ApiController
  before_action :set_order, only: %i[ update ]

  # GET /orders
  def index
    @orders = OrderSerializer.new(@user.orders.includes(:items).all)

    render json: @orders, status: :ok
  end

  # POST /orders
  def create
    @order = @user.orders.create(order_params)
    @order.calculate_total

    if @order.save
      render json: OrderSerializer.new(@order), status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: OrderSerializer.new(@order), status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(order_items_attributes: %i[item_id quantity])
    end
end
