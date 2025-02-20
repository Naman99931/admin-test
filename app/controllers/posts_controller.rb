class PostsController < InheritedResources::Base
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html{ redirect_to posts_path, notice: "Post created successfully." }
      else
        format.html{ redirect_to new_post_path, notice: "Please try again" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.html{ redirect_to posts_path, notice: "Post deleted successfully." }
      else
        format.html{ redirect_to posts_path, notice: "Please try again" }
      end
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
