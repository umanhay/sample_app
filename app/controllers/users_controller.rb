class UsersController < ApplicationController
  # By default before_action applies to all actions, so use 'only' to restrict to certain actions.
  # Make sure to add tests for this to users_controller_test.rb
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    # Use paginate method instead of .all
    # paginate takes page key and value of page requested. will_paginate gem auto generates page param.
    @users = User.paginate(page: params[:page])
  end

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
      # Temporary message on success using Rails flash method
      flash[:success] = "Welcome to the Sample App!"
      # Usual practice is to redirect upon save for create action
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
    # Update_attributes method accepts a hash of attributes
    # On success, this method updates and saves
    # Can use update_attibute to pass only one attribute
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        # Sessions helper method.
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
