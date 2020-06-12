class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])

    if @like.save
      flash[:notice] = 'You liked a post.'
    else
      flash[:alert] = 'You are deemed unworthy of liking.'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      flash[:notice] = 'You unliked a post.'
    else
      flash[:alert] = 'You cannot unlike this post.'
    end
    redirect_back(fallback_location: root_path)
  end
end
