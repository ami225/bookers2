class BooksController < ApplicationController
   before_action :authenticate_user!

   before_action :ensure_correct_user, only:[:edit, :destroy]



  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
  else
    @user = current_user
    @books = Book.page(params[:page]).reverse_order
    render :index
  end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user
    @book_new = Book.new
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find_by(id:params[:id])
  unless @book.user == current_user
    redirect_to books_path
  end
  end
end
