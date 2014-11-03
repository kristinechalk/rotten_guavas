  # Different because NOT dealing with a model (It's important to note that 
  # "resources" usually refer to models but not always.)
  # Because this controller isn't responsible for CRUD for a model, won't 
  # instantiated anything in 'new' action. And 'create' action looks 
  # quite a bit different than our typical create:

class SessionsController < ApplicationController

  def create
    # find the user based on the email in the "email" input field
    user = User.find_by(email: params[:email])
    # make sure that user exists and can be authenticated by the password in the "password" input field
    if user && user.authenticate(params[:password])
      # if so, we set the :user_id key in the sessions hash to the user's id. 
      # as you can guess, this is how we'll soon determine if a user is logged in.
      session[:user_id] = user.id
      # redirect to index page shows all movies & flash notice to user
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      # flash notice to user
      flash.now[:alert] = "Log in failed..."
      # show views/users/new.html.erb 
      render :new
    end
  end

  def destroy
    # simply clearing our session[:user_id] and redirecting.
    session[:user_id] = nil
    redirect_to movies_path, notice: "Chau!"
  end
end