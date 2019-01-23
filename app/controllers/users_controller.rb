class UsersController < ApplicationController


  def home
  end

  def about
  end

before_action :authenticate_user!, only: [:create, :index, :show, :edit, :update]

before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def ensure_correct_user
   @user = User.find(params[:id])
    if current_user.id != @user.id
       flash[:notice] = "error!!"
       redirect_to user_path(current_user.id)
    end
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

	def index
  	@book = Book.new
  	@users = User.all
  end

  def create
  	  book = Book.new(book_params)
  	  book.user_id = current_user.id
      if book.save
         redirect_to book_path(book.id)
         flash[:notice] = 'Book was successfully created.'
      else
        redirect_to books_path
        flash[:notice] = 'create error!!'
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
       redirect_to user_path(@user.id)
       flash[:notice] = 'Book was successfully updated.'
      else
       redirect_to edit_user_path(@user.id)
        flash[:notice] = 'update error!!'
      end
  end

    private

    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end
end
