class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # temporary message on success using Rails flash method
      flash[:success] = "Welcome to the Sample App!"
      # usual practice is to redirect upon save for create action
      # Rails infers this means user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # update_attributes method accepts a hash of attributes
    # on success, this method updates and saves
    # can use update_attibute to pass only one attribute
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
