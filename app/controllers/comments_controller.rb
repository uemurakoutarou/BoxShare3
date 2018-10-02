class CommentsController < ApplicationController
  before_action :move_to_index, only: [:create]
  # def new
  #   @fight = Fight.find(params[:fight_id])
  #   @comment_new = Comment.new()
  #   @comment_new.fight_id = @fight.id
  #   @comment = @fight.comments.includes(:fight)
  # end

  def create #form_forから
    if user_signed_in?
      Comment.create(comment_params)
      @fight = Fight.find(params[:fight_id])
      redirect_to fight_path(@fight)
      # @comments = @fight.comments.includes(:fight)
    else
      redirect_to :root, alert: "投稿には会員登録が必要です"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    @comments = Comment.all
  end


  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, fight_id: params[:fight_id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to :root, alert: '会員登録、ログインが必要です。'
    end
  end
end
