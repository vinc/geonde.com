class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(email: params.require(:email))
    if @subscriber.save
      flash[:notice] = "Thank you for subscribing"
    end
    redirect_to root_path
  end
end
