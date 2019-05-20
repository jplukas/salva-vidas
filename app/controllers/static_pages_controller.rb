class StaticPagesController < ApplicationController
  def home
  end
  def mensagem
    @mensagem = "Bom dia"
  end
end
