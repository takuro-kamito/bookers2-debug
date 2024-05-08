class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
    @currentUserEntry. each do |cu|
    @userEntry.each do |u|
      if cu.room_id == u.room_id
        @isRoom = true
        @roomId = cu.room_id
      end
    end
  end
  if @isRoom
  else
    @room = Room.new
    @entry = Entry.new
  end
    end
    @books = @user.books
    @book = Book.new
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    @books = Book.all
  end

  def update
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to book_path
    end

      @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def follows
  user = User.find(params[:id])
  @users = user.following_users
  end

  def followers
  user = User.find(params[:id])
  @user = user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end

