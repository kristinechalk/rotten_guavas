class ReviewsController < ApplicationController
  
  before_filter :load_movie, :restrict_access
  
  def new
    @review = @movie.reviews.build
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @movie, notice: "Review created successfully"
    else
      render :new
    end
  end

  protected

  def load_movie
    # grabbing the correct movie by using params[:movie_id]
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end

end

# Filters are simply methods that run before, after, or "around" 
# each controller action. In our ReviewsController, we have the 
# same line at the beginning of both actions:
# @movie = Movie.find(params[:movie_id])
