class PagesController < ApplicationController

  def main
    @products = Product.all.sort
    @referrer_code = params[:ref]
    @user_referrer = Order.find_by_referral_code(@referrer_code) if params[:ref]
  end


  def dashboard
    @product = Product.find(params[:h])
    @order = Order.find(params[:i])
    @price = @order.product.price_in_cent.to_f / 100
  end

end
