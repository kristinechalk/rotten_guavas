class MoviesController < ApplicationController
  def index
    # @variable accessible in /views/index.html.erb
    @movies = Movie.all 
  end

  def show
    @movie = Movie.find(params[:id]) 
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id]) 
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      # redirect to page listing all movies
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      # render app/views/movies/new.html.erb
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(movie_params)
      # redirect to same page (shows updated movie)
      redirect_to movie_path(@movie)
    else
      # render app/views/movies/edit.html.erb
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    # redirect to page listing all movies
    redirect_to movies_path
  end

  # only accessible within this class
  protected

  # security measure
  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description
    )
  end
end
