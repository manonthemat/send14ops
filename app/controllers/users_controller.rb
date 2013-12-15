class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    if @user != current_user
      outgoing = current_user.messages.where(recipient:params[:id])
      incoming = Message.where(user_id:params[:id], recipient:current_user)
      incoming.update_all(viewed: true)
      @sortedmsgs = (outgoing + incoming).sort_by(&:created_at).reverse!
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to send14ops!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :showtimeinfo)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
