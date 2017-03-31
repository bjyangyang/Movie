class MoviesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_movie_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @critics = @movie.critics.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user

    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    flash[:alert] = "Movie deleted"
    redirect_to movies_path
  end

    def join
     @movie = Movie.find(params[:id])

      if !current_user.is_member_of?(@movie)
        current_user.join!(@movie)
        flash[:notice] = "加入本评论版成功！"
      else
        flash[:warning] = "你已经是本评论版成员了！"
      end

      redirect_to movie_path(@movie)
    end

    def quit
      @movie = Movie.find(params[:id])

      if current_user.is_member_of?(@movie)
        current_user.quit!(@movie)
        flash[:alert] = "已退出本评论版！"
      else
        flash[:warning] = "你不是本评论版成员，怎么退出 XD"
      end

      redirect_to movie_path(@movie)
    end

  private
  def find_movie_and_check_permission
    @movie = Movie.find(params[:id])
    if current_user != @movie.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def movie_params
    params.require(:movie).permit(:片名, :简介)
  end

end
