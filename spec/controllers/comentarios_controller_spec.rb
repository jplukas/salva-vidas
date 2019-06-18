require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe ComentariosController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @material = cria_material('teste', cria_usuario('usuario@donomaterial.com'), Disciplina.find(1))
        @dados = {comentario: {conteudo: 'teste de comentário'}}
    end
    
    it 'Não deixa usuário não logado comentar material' do
        post material_comentarios_path(@material), params: @dados
        consulta = Comentario.all
        expect(consulta.count).to eq(0)
    end
    
    it 'Deixa usuário logado comentar material' do
        usuario = cria_usuario
        sign_in usuario
        post material_comentarios_path(@material), params: @dados
        consulta = Comentario.all
        expect(consulta.count).to eq(1)
        expect(consulta[0].user_id).to eq(usuario.id)
        expect(consulta[0].material_id).to eq(@material.id)
        expect(consulta[0].conteudo).to eq('teste de comentário')
    end
    
    it 'Mostra comentário na página do material' do
        cria_comentario
        get material_path(@material)
        expect(response.body).to include('novo comentário')
    end
    
    it 'Não mostra link de exclusão se o usuário não está logado' do
        usuario = cria_usuario
        Comentario.create! user: usuario, material: @material, conteudo: 'teste'
        get material_path(@material)
        expect(response.body).not_to match(/teste(.*)<a(.*)>Excluir<\/a>/m)
    end
    
    it 'Mostra link de exclusão somente para os comentários do usuário logado' do
        usu1 = cria_usuario('usu1@usuario.com')
        usu2 = cria_usuario('usu2@usuario.com')
        Comentario.create! user: usu1, material: @material, conteudo: 'com1'
        Comentario.create! user: usu2, material: @material, conteudo: 'com2'
        Comentario.create! user: usu1, material: @material, conteudo: 'com3'
        Comentario.create! user: usu2, material: @material, conteudo: 'com4'
        sign_in usu1
        get material_path(@material)
        expect(response.body).to match(/com1(.*)<a(.*)>excluir<\/a>(.*)com2(.*)com3(.*)<a(.*)>excluir<\/a>(.*)com4(.*)/m)
    end
    
    it 'Não deixa usuário não logado excluir comentário' do
        cria_comentario
        delete comentario_path(1)
        consulta = Comentario.all
        expect(consulta.count).to eq(1)
        expect(consulta[0].conteudo).to eq('novo comentário')
    end
    
    it 'Não deixa usuário comum logado excluir comentários de outros usuários' do
        usu1 = cria_usuario('usu1@usuario.com')
        usu2 = cria_usuario('usu2@usuario.com')
        Comentario.create! user: usu1, material: @material, conteudo: 'com1'
        Comentario.create! user: usu2, material: @material, conteudo: 'com2'
        sign_in usu1
        delete comentario_path(2)
        consulta = Comentario.all
        expect(consulta.count).to eq(2)
        expect(consulta[0].conteudo).to eq('com1')
        expect(consulta[1].conteudo).to eq('com2')        
    end
    
    it 'Deixa usuário comum logado excluir seu próprio comentário' do
        usu1 = cria_usuario('usu1@usuario.com')
        Comentario.create! user: usu1, material: @material, conteudo: 'com1'
        sign_in usu1
        delete comentario_path(1)
        consulta = Comentario.all
        expect(consulta.count).to eq(0)
    end
    
    it 'Deixa administrador excluir qualquer comentário' do
        cria_comentario
        admin = cria_admin
        sign_in admin
        delete comentario_path(1)
        consulta = Comentario.all
        expect(consulta.count).to eq(0)
    end
    
    it 'Mostra link para exclusão de todos os comentários para o admin' do
        usu1 = cria_usuario('usu1@usuario.com')
        usu2 = cria_usuario('usu2@usuario.com')
        Comentario.create! user: usu1, material: @material, conteudo: 'com1'
        Comentario.create! user: usu2, material: @material, conteudo: 'com2'
        Comentario.create! user: usu1, material: @material, conteudo: 'com3'
        Comentario.create! user: usu2, material: @material, conteudo: 'com4'
        sign_in cria_admin
        get material_path(@material)
        expect(response.body).to match(/com1(.*)<a(.*)>excluir<\/a>(.*)com2(.*)<a(.*)>excluir<\/a>(.*)com3(.*)<a(.*)>excluir<\/a>(.*)com4(.*)<a(.*)>excluir<\/a>(.*)/m)
    end
    
    it 'Não deixa usuário não logado dar like no comentário' do
        cria_comentario
        post voto_comentario_up_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(0)
    end
    
    it 'Não deixa usuário não logado dar dislike no comentário' do
        cria_comentario
        post voto_comentario_down_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(0)
    end
    
    it 'Deixa usuário logado dar like no material' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_up_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(1)
    end
    
    it 'Deixa usuário logado dar dislike no comentário' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_down_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(-1)
    end
    
    it '2 likes seguidos no comentário cancela' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_up_path, params: {id: 1}
        post voto_comentario_up_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(0)
    end
    
    it '2 dislikes seguidos no comentário cancela' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_down_path, params: {id: 1}
        post voto_comentario_down_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(0)
    end
    
    it 'Troca de like para dislike no comentário' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_up_path, params: {id: 1}
        post voto_comentario_down_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(-1)
    end
    
    it 'Troca de dislike para like no comentário' do
        cria_comentario
        sign_in cria_usuario
        post voto_comentario_down_path, params: {id: 1}
        post voto_comentario_up_path, params: {id: 1}
        com = Comentario.find(1)
        expect(com.voto_comentarios.sum(:sinal)).to eq(1)
    end
    
    def cria_comentario
        Comentario.create! user: cria_usuario('usuario@comentarista.com'), material: @material, 
                           conteudo: 'novo comentário'
    end
    
end
