class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.now[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      flash.now[:danger] = "Try Again!"
      render :new
    end
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end  

  # DELETE /users/1 or /users/1.json
  # def destroy
  #   User.find(params[:id]).destroy
  #   flash[:success] = "User deleted"
  #   redirect_to users_url
  # end
  def destroy
    @user = User.find(params[:id])
    if current_user.admin? && !current_user?(@user)
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    else
      flash[:danger] = "You are not authorized to delete this user"
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
  
end