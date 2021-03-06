class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:show, :edit,:destroy]
  # GET /order_items
  # GET /order_items.json

  # GET /order_items/1
  # GET /order_items/1.json

  # GET /order_items/new

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])  ###
    @order_item.quantity += 1
      respond_to do |format|
        if @order_item.save
          format.html { redirect_to @order, notice: 'Order item was successfully created.' }
          format.json { render :show, status: :created, location: @order_item }
        else
          format.html { render :new }
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
        end
          end
    end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order = Order.find_by(id: OrderItem.find_by(id: params[:id]).order_id)
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to order_path(@order), notice: 'Successfully added product to cart.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_url, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  attr_accessor :dlt_flags, :ordrid

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end
   
    def load_order
        @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
        if @order.new_record?
           @order.save!
           session[:order_id] = @order.id
     end
    end
end
