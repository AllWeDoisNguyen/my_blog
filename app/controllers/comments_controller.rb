class CommentsController < ApplicationController
	before_action :set_article, only: [:create, :destroy]

	http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASS'], only: :destroy

	def create
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end

	def destroy
	    @comment = @article.comments.find(params[:id])
	    @comment.destroy
	    redirect_to article_path(@article)
	  end

	private

	def comment_params
		params.require(:comment).permit(:commenter, :body)
	end

	def set_article
		@article = Article.find(params[:article_id])

	end

end
