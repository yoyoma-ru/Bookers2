class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  before_action :correct_user, only: [:edit, :update]

  def top
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
    @book = Book.new
    # .page(params[:page]).reverse_order
  end

  def edit
  end

  def update
  	if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
  	   redirect_to user_path(@user)
    else
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user)
    end
  end
end
