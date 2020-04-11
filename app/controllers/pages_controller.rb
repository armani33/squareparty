class PagesController < ApplicationController
  skip_before_action :authorized, only: [:main]

  def main
    redirect_to dashboard_path(:h => current_user.product_id, :i => current_user.id) if logged_in?

    @products = Product.all.sort
    @referrer_code = params[:ref]
    @user_referrer = Order.find_by_referral_code(@referrer_code) if params[:ref]
  end


  def dashboard
    @product = Product.find(params[:h])
    @order = Order.find(params[:i])
    @price = @order.product.price_in_cent.to_f / 100

    unless session[:user_id] == @order.id
      flash[:notice] = "You don't have access to that order!"
      redirect_to root_path
      # redirect_to dashboard_path(:h => @product, :i => @order)
      # render :template => 'pages/dashboard'
    end

  end



end
