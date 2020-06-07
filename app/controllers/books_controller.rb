class BooksController < ApplicationController
	before_action :authenticate_user!

	def new
	end

	def create
		@book = Book.new(book_params)
		@book.save
		flash[:notice] = "You have created book successfully."
		redirect_to books_path
	end

	def index
		@books = Book.all
		@book = Book.new
	end

	def show
		@book = Book.find(params[:id])
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end


end
