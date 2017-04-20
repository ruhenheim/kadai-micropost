class FavoritesController < ApplicationController
  before_action :require_user_logged_in, :set_micropost

  def create
    current_user.like(@micropost)
    flash[:success] = "お気に入り登録しました."
    redirect_back(fallback_location: root_path)
  end
  def destroy
    current_user.dislike(@micropost)
    flash[:success] = "お気に入り解除しました."
    redirect_back(fallback_location: root_path)
  end

  private
  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
end
