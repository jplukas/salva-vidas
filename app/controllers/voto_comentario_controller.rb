class VotoComentarioController < ApplicationController

    def up
        cria_ou_altera(params[:id], +1)
        render json: {pontos: pontuacao(params[:id])}
    end
    
    def down
        cria_ou_altera(params[:id], -1)
        render json: {pontos: pontuacao(params[:id])}
    end
    
private

    def pontuacao(id)
        VotoComentario.where(comentario_id: id).sum(:sinal)
    end
    
    def cria_ou_altera(id, sinal)
        query = {user_id: current_user.id, comentario_id: id}
        existente = VotoComentario.find_by(query)
        if existente == nil
           existente = VotoComentario.create(query)
        end
        existente.sinal = sinal
        existente.save!
    end

end
