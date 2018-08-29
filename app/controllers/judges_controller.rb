class JudgesController < ApplicationController
  def new
    
  end

  def create
    if user_signed_in?
      Judge.create(create_params)
      @fight = Fight.find(params[:judge][:fight_id])
      redirect_to fight_path(@fight)
      @comments = Comment.all
      @judges = @fight.judges.includes(:fight)
      @user_judges = Judge.where(user_id: current_user.id, fight_id: @fight.id)
    else
      redirect_to :root, alert: "投稿には会員登録が必要です"
    end
  end

  def edit
    
  end

  def update
    
  end

  private
  def create_params
    params.require(:judge).permit(:fight_id,:round,:range).merge(user_id: current_user.id)
  end
end
