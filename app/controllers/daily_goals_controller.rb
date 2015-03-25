#encoding=utf-8

class DailyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    notice_text = "#{view_context.datestring}의 목표를 변경했습니다: #{@daily_goal.description} -> #{daily_goal_params[:description]}"
    if @daily_goal.update(daily_goal_params)
      redirect_to root_url, notice: notice_text
    else
      render :edit
    end
  end

  def destroy
    @daily_goal.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Daily goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_daily_goal
      @daily_goal = DailyGoal.find(params[:id])
    end

    def daily_goal_params
      params.require(:daily_goal).permit(:description, :goal_date, :user_id)
    end
end
