class StaticPagesController < ApplicationController
  def home
    @ultimos = Material.order(id: :desc).limit(10)
  end
end
