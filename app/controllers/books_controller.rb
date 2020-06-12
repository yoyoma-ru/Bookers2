class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		  flash[:success] = "You have created book successfully."
		  redirect_to book_path(@book)
	    else
	      @books = Book.all
		  @user = current_user
	      render action: :index
	    end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def show
		@book = Book.new
		@detail = Book.find(params[:id])
		@user = @detail.user
	end

	def edit
	end

	def update
		if  @book.update(book_params)
			flash[:success] = "You have updated book successfully."
		    redirect_to book_path(@book)
		else
			render action: :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
	def correct_user
		@book = Book.find(params[:id])
		@user = @book.user
		if current_user != @user
		   redirect_to books_path
		end
	end

end
