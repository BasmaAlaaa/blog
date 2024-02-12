class CommentsController < ApplicationController
    before_action :set_comment, only: [:destroy]
    before_action :check_user, only: [:destroy]

    def create
        @blog_post = BlogPost.find(params[:blog_post_id])
        # Build the comment associated with @blog_post and current_user
        @comment = @blog_post.comments.new(comment_params)
        @comment.user = current_user # Associate the comment with the current user
        if @comment.save
            redirect_to blog_post_path(@blog_post), notice: 'Comment was successfully created.'
          else
            redirect_to blog_post_path(@blog_post), alert: 'Comment could not be created.'
          end
    end
    def destroy
        @blog_post = BlogPost.find(params[:blog_post_id])
        @comment = @blog_post.comments.find(params[:id])
        @comment.destroy
        redirect_to blog_post_path(@blog_post)
    end

    def show
        @blog_post = BlogPost.find(params[:blog_post_id])
        @comment = @blog_post.comments.find(params[:id])
    end
    private
    def comment_params
        params.require(:comment).permit(:content)
    end
    def set_comment
        @comment = Comment.find(params[:id])
      end
      
      def check_user
        unless current_user == @comment.user
          redirect_to blog_post_path(@comment.blog_post), alert: "Not authorized to delete this comment"
        end
    end
end
