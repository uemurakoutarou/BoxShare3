class UsersController < ApplicationController
  before_action :move_to_index, only: :edit
  def show
    @user = User.find(params[:id])
    @judge = @user.fights.uniq
    @forecasts = @user.forecasts.includes(:user)
  end

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to "/users/#{current_user.id}"
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
    render "following"
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render "follower"
  end


  private
  def update_params
    params.require(:user).permit(:nickname)
  end

  def move_to_index
    @user = User.find(params[:id])
    unless user_signed_in? && @user.id == current_user.id
      redirect_to :root, alert: '本人のみ編集可能です。'
    end
  end
end
