class LikesController < ApplicationController
  before_action :logged_id
  def create
    @comment = Comment.find(params[:comment_id])
    unless @comment.like?(current_user)
      @comment.like(current_user)
      @comment.reload
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  def destroy
    @comment = Like.find(params[:id]).comment
    if @comment.like?(current_user)
      @comment.unlike(current_user)
      @comment.reload
      respond_to do |format|
        format.html {redirect_to request.referrer || root_url}
        format.js
      end
    end
  end

  private
  def logged_id
    unless user_signed_in?
      redirect_to :root, alert: "会員登録、ログインが必要です。"
    end
  end
end
