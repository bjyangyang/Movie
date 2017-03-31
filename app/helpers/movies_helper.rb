module MoviesHelper
  def render_movie_简介(movie)
    simple_format(movie.简介)
  end
end
