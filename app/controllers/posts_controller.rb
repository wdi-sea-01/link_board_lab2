class PostsController < ApplicationController

    def index
        @posts = Post.all
        respond_to do |format|
            format.json {render json: @posts}
            format.html
            format.xml {render xml: @posts}
        end

        
    end

    def show
    end

    def new
        @post = Post.new
    end     

    def create
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])
      @post = user.posts.create post_params
      if @post.errors.any?
        render :new
      else
        flash[:success] = 'Post added'
        redirect_to posts_path
      end
    end

    def edit
    end   

    def update
    end

    def destroy
    end    

    def comments
      @post = Post.find_by_id(params[:id])
      @comment = Comment.new
    end

    def create_comment
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])      
      post = Post.find_by_id(params[:id])
      user.comments << post.comments.create({body:params[:comment][:body]})
      redirect_to post_comments_path
    end

    def create_vote
      return unless is_authenticated?
      user = User.find_by_id(@current_user['id'])      
      post = Post.find_by_id(params[:id])
      existing_vote = post.votes.where(user_id: user.id).any?

      if existing_vote
        flash[:warning]="you already upvoted this once"
      else
        user.votes << post.votes.create
      end

      respond_to do |format|
        format.json { render json: {result: !existing_vote,votes:post.votes.length} }
        format.html {redirect_to posts_path}
      end      
    end

  private

  def post_params
    params.require(:post).permit(:title,:link)
  end


end