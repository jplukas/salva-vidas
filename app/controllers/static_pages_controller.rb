class StaticPagesController < ApplicationController
  def home
    @materiais = user_signed_in? ? current_user.feed : Material.order(created_at: :desc).limit(10)
  end
end
