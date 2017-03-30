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


  private

  def critic_params
    params.require(:critic).permit(:content)
  end

end
