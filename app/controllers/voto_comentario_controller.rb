class VotoComentarioController < ApplicationController

    before_action :authenticate_user!

    def up
        novo_voto = cria_ou_altera(params[:id], +1)
        render json: {voto: novo_voto, pontos: pontuacao(params[:id])}
    end
    
    def down
        novo_voto = cria_ou_altera(params[:id], -1)
        render json: {voto: novo_voto, pontos: pontuacao(params[:id])}
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
           existente.sinal = sinal
           existente.save!
        elsif existente.sinal == sinal
           existente.destroy!
           return 0
        else
           existente.sinal = sinal
           existente.save!
        end
        return sinal
    end

end
