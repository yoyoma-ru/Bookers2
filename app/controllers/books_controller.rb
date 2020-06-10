class BooksController < ApplicationController
	before_action :authenticate_user!

	def new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
		  flash[:notice] = "You have created book successfully."
		  redirect_to book_path(@book.user_id)
	    # else
	      # @books = Book.all
	      # render action: :index
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
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		@book.update(book_params)
		redirect_to book_path(params[:id])
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


end
