require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe StaticPagesController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
    end

    it 'Mostra 10 últimos materiais para o visitante' do
        user = cria_usuario
        disciplina = Disciplina.first
        11.times { |i| cria_material("teste#{i}", user, disciplina) }
        get root_path
        10.times { |i|
            expect(response.body).to include("teste#{i+1}")
        }
        expect(response.body).not_to include("teste0")
    end
    
    it 'Mostra o feed para o usuário logado' do
        user1 = cria_usuario
        user2 = cria_usuario('another@user.com')
        disciplina1 = Disciplina.find(1)
        disciplina2 = Disciplina.find(2)
        5.times { |i| cria_material("A#{i}", user1, disciplina1) }
        5.times { |i| cria_material("B#{i}", user1, disciplina2) }
        RelUserDisciplina.create! seguidor: user2, seguido: disciplina2
        sign_in user2
        get root_path
        5.times { |i| expect(response.body).not_to include("A#{i}") }
        5.times { |i| expect(response.body).to include("B#{i}") }
    end
    
end
