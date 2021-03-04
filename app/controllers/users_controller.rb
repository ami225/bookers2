class UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_correct_user, only:[:edit, :destroy]

  def index
    @users = User.page(params[:page]).reverse_order
    @book = Book.new
  end

  def create
     @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
  end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "userinfo was successfully updated."
      redirect_to user_path(@user.id)
    else
      @users = User.page(params[:page]).reverse_order
      render :edit
    end
  end





  private

  def user_params
   params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end
end
