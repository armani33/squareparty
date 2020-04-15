class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    user = Order.find_by_email(params[:email]) if Order.find_by_email(params[:email]) #.status == 'paid' unless Order.find_by_email(params[:email]).nil?
    product = Product.find(user.product_id) unless user.nil?


    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path(:h => product.id, :i => session[:user_id]), notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end

