class BookCommentsController < ApplicationController
  
  def create
    book = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to require.referer
  end 
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
    
  end
end
