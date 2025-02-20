class CommentsController < InheritedResources::Base
  before_action :authenticate_user!
  def index
    #post = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @comments = Comment.where(post_id:@post.id)
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html{ redirect_to post_path(post.id), notice: "Comment Created successfully." }
      else
        format.html{ redirect_to post_path(post.id), notice: "Try Again." }
      end
    end
  end
  private

    def comment_params
      params.require(:comment).permit(:note)
    end
end
