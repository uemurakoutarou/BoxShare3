class ForecastsController < ApplicationController
  before_action :move_to_index, only: [:create, :edit, :update]
  def new
    @fight = Fight.find(params[:fight_id])
    @forecast = Forecast.new
    @forecast.fight_id = @fight.id
    @forecasts = @fight.forecasts.includes(:fight)
    @real_forecast = @forecasts.where.not(detail: "")
    if user_signed_in?
      @user_support = Forecast.find_by(user_id: current_user.id, fight_id: @fight.id)
    end
  end

  def create
    if user_signed_in?
      my_forecast = Forecast.find_by(user_id: current_user.id, fight_id: params[:forecast][:fight_id])
      if my_forecast.blank?
        @forecast = Forecast.create(create_params)
        if @forecast.save
          redirect_to new_forecast_path(fight_id: @forecast.fight_id)
        else
          redirect_to new_forecast_path(fight_id: @forecast.fight_id), alert: '選択してください'
        end
      else
        redirect_to root, alert: '既に投稿しています'
      end
    else
      redirect_to :root, alert: '投稿には会員登録、ログインが必要です。'
    end
  end

  def edit
    @fight = Fight.find(params[:fight_id])
    @forecasts = @fight.forecasts.includes(:fight)
    @real_forecast = @forecasts.where.not(detail: "")
    if user_signed_in?
      @forecast = Forecast.find_by(user_id: current_user.id, fight_id: @fight)
    end
  end

  def update
    @forecast = Forecast.find(params[:id])
    if user_signed_in?
      @forecast.update(create_params)
      redirect_to new_forecast_path(fight_id: @forecast.fight_id)
    else
      redirect_to :root, alert: '投稿には会員登録、ログインが必要です。'
    end
  end

  def destroy
    
  end

  private
  def create_params
    params.require(:forecast).permit(:fight_id, :detail, :support).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to :root, alert: '会員登録、ログインが必要です。'
    end
  end
end
