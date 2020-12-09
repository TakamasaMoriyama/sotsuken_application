class MoodlesController < ApplicationController
  def new
  end

  def create
    Moodle.create(username: params[:moodle][:username], password: params[:moodle][:password])
    redirect_to "/"
  end

  def destroy
    Moodle.all[0].destroy
    redirect_to "/"
  end
end
