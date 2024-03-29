class BlogPostsController < ApplicationController
before_action :authenticate_user!
before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
before_action :check_user, only: [:edit, :update, :destroy]


    def index
        @blog_posts = BlogPost.all
    end

    def show
     #   @blog_post = BlogPost.find(params[:id])
        #when you enter an invalid id, it will redirect to the root path
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end

    def new
        @blog_post = BlogPost.new
    end

    def create
       # @blog_post = BlogPost.new(blog_post_params)
       @blog_post = current_user.blog_posts.new(blog_post_params) # This associates the new blog post with the current user
        if @blog_post.save
            redirect_to blog_post_path(@blog_post)
        else
            render :new ,status: :unprocessable_entity
        end
    end

    def edit
      #  @blog_post = BlogPost.find(params[:id])
    end

    def update
     #   @blog_post = BlogPost.find(params[:id])
        if @blog_post.update(blog_post_params)
            redirect_to blog_post_path(@blog_post)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
      #  @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy
        redirect_to root_path, notice: 'Blog post was successfully deleted.'
      end
    private
    def blog_post_params
        params.require(:blog_post).permit(:title, :body)
    end

    def set_blog_post
        @blog_post = BlogPost.find(params[:id])
    end

    def check_user
        unless current_user == @blog_post.user
        redirect_to blog_posts_path, alert: "Not authorized to edit or delete this blog post"
    end
end
end