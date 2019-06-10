class StaticPagesController < ApplicationController
  def home
    @materiais = user_signed_in? ? current_user.feed : Material.order(created_at: :desc)
  end

  def perfil
    if user_signed_in?
      @user = current_user
    else
      flash[:danger] = "You have to be logged in to do that"
      redirect_to new_user_session_path
    end
  end
end
