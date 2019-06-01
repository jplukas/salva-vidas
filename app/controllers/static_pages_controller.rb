class StaticPagesController < ApplicationController
  def home
    @feed = 'oi'
    #@feed = current_user.materiais_seguidos.order(created_at: :desc)
  end
end
