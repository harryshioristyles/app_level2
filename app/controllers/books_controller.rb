class BooksController < ApplicationController

before_action :authenticate_user!

before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def ensure_correct_user
   @libro = Book.find(params[:id])
    if current_user.id != @libro.user_id
       flash[:notice] = "error!!"
       redirect_to user_path(current_user.id)
    end
end

  def show
    @book = Book.new
    @libro = Book.find(params[:id])
  end

  def index
  	@books = Book.all
  	@book = Book.new
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
    @libro = Book.find(params[:id])
  end

  def update
    libro = Book.find(params[:id])
      if  libro.update(book_params)
        redirect_to book_path(libro.id)
        flash[:notice] = 'Book was successfully updated.'
      else
        redirect_to edit_book_path(libro.id)
        flash[:notice] = 'update error!!'
      end
  end

  def destroy
    libro = Book.find(params[:id])
        if libro.destroy
           redirect_to books_path
           flash[:notice] = 'Book was successfully destroyed.'
        else
           render book_path(libro.id)
           flash[:notice] = 'destroy error!!'
        end
  end


    private

    def book_params
      params.require(:book).permit(:book_name, :caption)
    end

end
