require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe DisciplinasController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @usuario = cria_usuario
        @outro_usuario = cria_usuario('outro@user.com')
        disc = Disciplina.find(1)
        cria_material 'Mat1', @usuario, disc
        cria_material 'Mat2', @usuario, disc
        cria_material 'Mat3', @usuario, disc
    end
    
    it 'Mostra os materiais da disciplina' do
        get disciplina_path(1)
        expect(response.body).to include('Mat1')
        expect(response.body).to include('Mat2')
        expect(response.body).to include('Mat3')
    end
    
    it 'Mostra o número de likes' do
        distribui_likes
        get disciplina_path(1)
        expect(response.body).to match(/1 Ponto(.*)Mat1(.*)-1 Ponto(.*)Mat2(.*)-2 Pontos(.*)Mat3/m)
    end
    
    def distribui_likes
        Voto.create! user: @usuario, material_id: 1, sinal: +1
        Voto.create! user: @usuario, material_id: 3, sinal: -1
        Voto.create! user: @outro_usuario, material_id: 2, sinal: -1
        Voto.create! user: @outro_usuario, material_id: 3, sinal: -1
    end

end
