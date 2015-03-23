class DailyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_goal, only: [:show, :edit, :update, :destroy]

  def index
    @daily_goals = DailyGoal.all
  end

  def show
  end

  def new
    @daily_goal = current_user.daily_goals.build
    @daily_goal.goal_date = view_context.today
  end

  def edit
  end

  def create
    @daily_goal = current_user.daily_goals.build(daily_goal_params)

    respond_to do |format|
      if @daily_goal.save
        format.html { redirect_to root_url, notice: 'Daily goal was successfully created.' }
        format.json { render :show, status: :created, location: @daily_goal }
      else
        format.html { render :new }
        format.json { render json: @daily_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @daily_goal.update(daily_goal_params)
        format.html { redirect_to root_url, notice: 'Daily goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_goal }
      else
        format.html { render :edit }
        format.json { render json: @daily_goal.errors, status: :unprocessable_entity }
      end
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