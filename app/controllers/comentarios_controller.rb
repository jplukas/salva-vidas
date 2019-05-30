class ComentariosController < ApplicationController

  before_action :authenticate_user!

  def create
    @comentario = Comentario.new(comentario_params)
    @comentario.user_id = current_user.id
    @comentario.material_id = params[:material_id]
    if @comentario.save
      flash[:success] = "Cadastro realizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    redirect_to material_path(@comentario.material)
  end

  def destroy
    @comentario = Comentario.find(params[:id])
    url = url_for(@comentario.material)
    @comentario.destroy
    redirect_to url
  end

  private
  def comentario_params
    params.require(:comentario).permit(:conteudo)
  end
end
