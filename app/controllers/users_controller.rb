class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # create session 
      session[:user_id] = @user.id
      # redirect to page with all movies & flash notice to user
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      # show page of new movies created
      render :new
    end
  end 

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end

# note:
# has_secure_password, adds virtual attributes password and password_confirmation 
# to User model.