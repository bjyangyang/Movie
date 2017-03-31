class CriticsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @movie = Movie.find(params[:movie_id])
    @critic = Critic.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @critic = Critic.new(critic_params)
    @critic.movie = @movie
    @critic.user = current_user

    if @critic.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @critic = Critic.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @critic = Critic.find(params[:id])
    if @critic.update(critic_params)
      redirect_to account_critics_path, notice: 'Critic Update Success'
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @critic = Critic.find(params[:id])
    @critic.destroy
    redirect_to account_critics_path, alert: 'Critic deleted'
  end




  private

  def critic_params
    params.require(:critic).permit(:content)
  end

end
