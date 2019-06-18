require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe MaterialsController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @dados = {nome: 'teste', conteudo: 'teste', link: 'teste'}
    end
    
    it 'Não deixa usuário não logado criar material' do
        post disciplina_materials_path(1), params: {material: @dados}
        consulta = Material.all
        expect(consulta.count).to eq(0)
    end
    
    it 'Deixa usuário logado criar material' do
        sign_in cria_usuario
        post disciplina_materials_path(1), params: {material: @dados}
        consulta = Material.all
        expect(consulta.count).to eq(1)
        corresponde consulta[0], @dados
    end
    
    it 'Não deixa usuário não logado dar like no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        post voto_up_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(0)
    end
    
    it 'Não deixa usuário não logado dar dislike no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        post voto_down_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(0)
    end
    
    it 'Deixa usuário logado dar like no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_up_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(1)
    end
    
    it 'Deixa usuário logado dar dislike no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_down_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(-1)
    end
    
    it '2 likes seguidos no material cancela' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_up_path, params: {id: 1}
        post voto_up_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(0)
    end
    
    it '2 dislikes seguidos no material cancela' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_down_path, params: {id: 1}
        post voto_down_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(0)
    end
    
    it 'Troca de like para dislike no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_up_path, params: {id: 1}
        post voto_down_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(-1)
    end
    
    it 'Troca de dislike para like no material' do
        cria_material 'exemplo', cria_usuario, Disciplina.find(1)
        sign_in cria_usuario('outro@user.com')
        post voto_down_path, params: {id: 1}
        post voto_up_path, params: {id: 1}
        mat = Material.find(1)
        expect(mat.votos.sum(:sinal)).to eq(1)
    end
    
    def corresponde(material, dados)
        expect(material.nome).to eq(dados[:nome])
        expect(material.conteudo).to eq(dados[:conteudo])
        expect(material.link).to eq("http://#{dados[:link]}")
        expect(material.user_id).to eq(1)
        expect(material.disciplina_id).to eq(1)
    end
    
end
