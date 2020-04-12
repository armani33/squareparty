class OrdersController < ApplicationController
  skip_before_action :authorized, only: [:edit, :create, :update]
  def edit
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:id])
  end

  def create
    @referrer_code = params[:ref]

    @product = Product.find(params[:product_id])
    @order = @product.orders.new(order_info_params)

    @order.status = 'pending'
    @discount_code = @order.discount_code

    if @order.valid?

      if @order.save

        if @discount_code == ""
          redirect_to product_payment_order_path(product_id: @product, id: @order, :ref => @referrer_code)
        else
          if @discount_code == Discount.find_by_discount_code(@discount_code).discount_code
            @order.status = 'free'
            @order.save
            Discount.find_by_discount_code(@order.discount_code).destroy
            session[:user_id] = @order.id
            redirect_to dashboard_path(:h => @product, :i => @order)
          else
            redirect_to product_payment_order_path([@product.id, @order.id], :r => @referrer_code)
          end
        end
      else
        # flash[:error] = "Something went wrong! Could not save."
      render :template => 'products/show'
      end

    else

    render :template => 'products/show'


    end
  end

  def update
    @product = Product.find(params[:product_id])
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order.status = 'paid'


    @referrer_code = params[:ref]
    @order.referrer = Order.find_by_referral_code(@referrer_code) if @referrer_code

    if @order.save

      Stripe.api_key = ENV["STRIPE_TEST_SECRET_KEY"]

      Stripe::Charge.create(
        :amount => @product.price_in_cent,
        :currency => "eur",
        :card => @order.stripe_token # obtained with Stripe.js
      )

      session[:user_id] = @order.id
      redirect_to dashboard_path(:h => @product, :i => @order)
    else
      flash[:error] = "Oops, something went wrong"
      redirect_to product_payment_order_path(product_id: params[:product_id], id: @order)
    end

  rescue Stripe::CardError => e
    body = e.json_body
    err  = body[:error]
    flash[:error] = err[:message]
    render :edit
  end


  private

    def order_info_params
      params.require(:order).permit(:product_id, :email, :password, :first_name, :last_name, :address, :zip_code, :city, :country, :discount_code)
    end

    def order_params
      params.require(:order).permit(:stripe_token)
    end
end
