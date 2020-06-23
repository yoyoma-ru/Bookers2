class BookCommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :current_user, only: [:create, :destroy]
	def create
		book = Book.find(params[:book_id])
		comment = BookComment.new(comment_params)
		comment.user_id = current_user.id
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		book = Book.find(params[:book_id])
		comment = BookComment.find(params[:id])
		comment.user_id = current_user.id
		comment.book_id = book.id
		comment.destroy
		redirect_to book_path(params[:book_id])
	end

	private
	def comment_params
		params.require(:book_comment).permit(:comment)
	end
	def correct_user
		@comment = BookComment.find(params[:id]) #_by(id: params[:id], book_id: params[:book_id])
		@user = @comment.user
		if current_user != @user
		   redirect_to books_path
		end
	end
end
