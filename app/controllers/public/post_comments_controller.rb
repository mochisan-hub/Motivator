class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "投稿しました"
    else
      flash[:alert] = "投稿に失敗しました"
    end
    redirect_to public_post_path(post)
  end

  def destroy
    PostComment.find_by_id(params[:id])&.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to public_post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
