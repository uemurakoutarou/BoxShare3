class FightsController < ApplicationController
  before_action :move_to_index, only: :edit
  def index
    @fight = Fight.order("created_at DESC")
  end

  def show
    @fight = Fight.find(params[:id])
    @comments = @fight.comments.includes(:fight).order("comments.created_at DESC")
    @comment = Comment.new
    @judges = @fight.judges.includes(:fight)
    @judge = Judge.new
    if user_signed_in?
      @user_judges = @judges.where(user_id: current_user.id, fight_id: @fight.id)
    end
  end

  def new
    unless user_signed_in?
      redirect_to :root, alert: '投稿には会員登録、ログインが必要です。'
    else
      @fight = Fight.new
    end
  end

  def create
    @fight = Fight.create(fight_params)
    if @fight.save
      redirect_to :root and return
    else
      redirect_to new_fight_path, alert: '必要事項を埋めてください'
    end
  end

  def edit
    @fight = Fight.find(params[:id])
  end

  def update
    @fight = Fight.find(params[:id])
    @fight.update(fight_params)
    if @fight.save
      redirect_to :root and return
    else
      redirect_to new_fight_path, alert: '必要事項を埋めてください'
    end
  end

  def destroy
    
  end

  def search
    @fight =Fight.where('player_A LIKE(?) or player_B LIKE(?)',"%#{params[:keyword]}%", "%#{params[:keyword]}%").order("id ASC").limit(20)
  end


  private
  def fight_params
    params.require(:fight).permit(:name,:image,:date,:place,:player_A,:player_B,:detail,:all_round).merge(user_id: current_user.id)
  end

  def move_to_index
    @fight = Fight.find(params[:id])
    unless user_signed_in? && @fight.user_id == current_user.id
      redirect_to :root, alert: '投稿者本人のみ編集可能です。'
    end
  end
end
