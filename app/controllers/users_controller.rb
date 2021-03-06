class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
    # respond_to do |format|
    #   format.json do 
    #     render json: @user
    #   end
    #   format.xml do 
    #     render xml: @user
    #   end
    #   format.html
    # end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You registered! Welcome, #{params[:user][:username]}!"
      session[:user_id] = @user.id
      redirect_to posts_path
    else 
      render :new 
    end
  end

  def edit; end

  def update
    @user.update_attributes(user_params)
    if @user.save
      flash[:notice] = "You updated your info, #{@user.username}!"
      session[:user_id] = @user.id
      redirect_to posts_path
    else 
      render :edit
    end
  end

  private 

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end
