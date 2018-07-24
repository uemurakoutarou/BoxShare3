class LikesController < ApplicationController
  before_action :logged_id
  def create
    @comment = Comment.find(params[:comment_id])
    @comment.like(current_user)
    @comment.reload
    respond_to do |format|
      format.html {redirect_to @comment}
      format.js
    end
  end

  def destroy
    @comment = Like.find(params[:id]).comment
    @comment.unlike(current_user)
    @comment.reload
    respond_to do |format|
      format.html {redirect_to @comment}
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
