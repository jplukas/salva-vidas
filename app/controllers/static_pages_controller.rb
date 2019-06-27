class StaticPagesController < ApplicationController
  def home
    @materiais = user_signed_in? ? current_user.feed : Material.order(created_at: :desc).limit(10)
  end

  def bookmarks
    if !user_signed_in?
      flash[:danger] = "You have to be logged in to do that"
      redirect_to new_user_session_path
    end
    @materiais = current_user.material_bookmarks
  end
end
