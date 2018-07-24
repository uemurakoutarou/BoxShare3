class RelationshipsController < ApplicationController
  before_action :logged_id
  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  def logged_id
    unless user_signed_in?
      redirect_to :root, alert: "会員登録、ログインが必要です。"
    end
  end
end
