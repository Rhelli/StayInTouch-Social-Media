class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])

    if @like.save
      redirect_to posts_path, notice: 'You liked a post.'
    else
      redirect_to posts_path, alert: 'You are deemed unworthy of liking functionality.'
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      redirect_to posts_path, notice: 'You unliked a post.'
    else
      redirect_to posts_path, alert: "You cannot unlike a post you don't yet like!"
    end
  end
end
