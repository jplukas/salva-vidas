require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe CursosController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @curso = Curso.find(1)
    end
    
    it 'Não mostra ícones de favoritos para usuário não logado' do
        get curso_path(@curso)
        expect(response.body).not_to include('favorito-ativo')
        expect(response.body).not_to include('favorito-inativo')
    end
    
    it 'Mostra ícones de favoritos para usuário logado' do
        usuario = cria_usuario
        RelUserDisciplina.create! seguidor: usuario, seguido: @curso.disciplinas[0]
        sign_in usuario
        get curso_path(@curso)
        expect(response.body).to match(/Disc1-c1(.*)favorito-ativo(.*)Disc2-c1(.*)favorito-inativo(.*)/m)
    end
    
    it 'Mostra ícones de favoritos para usuário logado 2' do
        usuario = cria_usuario
        RelUserDisciplina.create! seguidor: usuario, seguido: @curso.disciplinas[1]
        sign_in usuario
        get curso_path(@curso)
        expect(response.body).to match(/Disc1-c1(.*)favorito-inativo(.*)Disc2-c1(.*)favorito-ativo(.*)/m)
    end
    
    it 'Não deixa usuário não logado favoritar' do
        post favoritar_path, params: {id: 1}
        expect(RelUserDisciplina.count).to eq(0)
    end
    
    it 'Não deixa usuário não logado remover favorito' do
        disc = @curso.disciplinas[1]
        usuario = cria_usuario
        RelUserDisciplina.create! seguidor: usuario, seguido: disc
        post favoritar_path, params: {id: 1}
        expect(RelUserDisciplina.count).to eq(1)
        rel = RelUserDisciplina.first
        expect(rel.seguidor).to eq(usuario)
        expect(rel.seguido).to eq(disc)
    end
    
    it 'Adiciona favorito' do
        usuario = cria_usuario
        disc = @curso.disciplinas[1]
        sign_in usuario
        post favoritar_path, params: {id: disc.id}
        expect(RelUserDisciplina.count).to eq(1)
        rel = RelUserDisciplina.first
        expect(rel.seguidor).to eq(usuario)
        expect(rel.seguido).to eq(disc)
    end
    
    it 'Remove favorito' do
        disc = @curso.disciplinas[1]
        usuario = cria_usuario
        RelUserDisciplina.create! seguidor: usuario, seguido: disc
        sign_in usuario
        post favoritar_path, params: {id: disc.id}
        expect(RelUserDisciplina.count).to eq(0)    
    end

end
