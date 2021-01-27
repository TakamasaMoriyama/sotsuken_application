class SubscriptionsController < ApplicationController
  def new

  end

  def create
    subscription = Subscription.create(
      username: params[:logs][:moodle_username],
      password: params[:logs][:moodle_password],
      url: params[:logs][:moodle_url],
      logname: params[:logs][:log_name]
    )
    redirect_to "/"
  end
end
