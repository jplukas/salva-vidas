require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe CursosController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @dados = {nome: 'teste', desc: 'teste'}
    end
    
    it 'Mostra as disciplinas cadastrados' do
        get curso_path(1)
        expect(response.body).to include("Disc1-c1")
        expect(response.body).to include("Disc2-c1")
    end
    
    it 'Não deixa usuário não autenticado criar disciplina' do
        testa_impede_criar_disciplina
    end
    
    it 'Não deixa usuário comum criar disciplina' do
        sign_in cria_usuario
        testa_impede_criar_disciplina
    end
    
    it 'Deixa admin criar disciplina' do
        sign_in cria_admin
        tenta_criar_disciplina
        consulta = Disciplina.where(@dados)
        expect(consulta.count).to eq(1)
    end
    
    it 'Não deixa usuário não autenticado editar disciplina' do
        testa_impede_editar_disciplina
    end
    
    it 'Não deixa usuário comum editar disciplina' do
        sign_in cria_usuario
        testa_impede_editar_disciplina
    end
    
    it 'Deixa admin editar disciplina' do
        sign_in cria_admin
        tenta_editar_disciplina(1)
        disc = Disciplina.find(1)
        expect(disc.nome).to eq(@dados[:nome])
        expect(disc.desc).to eq(@dados[:desc])
    end
    
    it 'Não deixa usuário não autenticado excluir disciplina' do
        testa_impede_excluir_disciplina
    end
    
    it 'Não deixa usuário comum excluir disciplina' do
        sign_in cria_usuario
        testa_impede_excluir_disciplina
    end
    
    it 'Deixa admin excluir disciplina' do
        disc = Disciplina.create!(nome: 'Disciplina teste', desc: 'kkk',
               curso: Curso.find(1))
        sign_in cria_admin
        tenta_excluir_disciplina(disc.id)
        consulta = Disciplina.find_by(id: disc.id)
        expect(consulta).to eq(nil)
    end
    
    it 'Não deixa usuário não autenticado upar figura' do
        testa_impede_upar_figura
    end
    
    it 'Não deixa usuário comum upar figura' do
        sign_in cria_usuario
        testa_impede_upar_figura
    end
    
    it 'Deixa admin upar figura' do
        sign_in cria_admin
        tenta_upar_figura(1)
        expect(response).to redirect_to(controller: :disciplinas, action: :index, curso_id: 1)
    end
    
    it 'Não mostra os links de criar, editar, excluir e upar figura para usuário não autenticado' do
        testa_nao_mostra_links
    end
    
    it 'Não mostra os links de criar, editar, excluir e upar figura para usuário comum' do
        sign_in cria_usuario
        testa_nao_mostra_links
    end
    
    it 'Mostra os links de criar, editar, excluir e upar figura para admin' do
        sign_in cria_admin
        testa_mostra_links
    end
    
    def testa_impede_criar_disciplina
        tenta_criar_disciplina
        expect(response.status).to eq(302)
        consulta = Disciplina.where(@dados)
        expect(consulta.count).to eq(0)
    end
    
    def tenta_criar_disciplina
        @dados[:curso] = Curso.find(1)
        post curso_disciplinas_path(1), params: {disciplina: @dados}
    end
    
    def testa_impede_editar_disciplina
        tenta_editar_disciplina(1)
        expect(response.status).to eq(302)
        disc = Disciplina.find(1)
        expect(disc.nome).to eq('Disc1-c1')
        expect(disc.desc).to eq('kkk')
    end
    
    def tenta_editar_disciplina(id)
        put disciplina_path(id), params: {disciplina: @dados}
    end
    
    def testa_impede_excluir_disciplina
        tenta_excluir_disciplina(1)
        consulta = Disciplina.all
        expect(consulta.count).to eq(4)
    end
    
    def tenta_excluir_disciplina(id)
        delete disciplina_path(id)
    end
    
    def testa_impede_upar_figura
        tenta_upar_figura(1)
        expect(response).not_to redirect_to(controller: :disciplinas, action: :index, curso_id: 1)
    end
    
    def tenta_upar_figura(id)
        arq = fixture_file_upload('files/upload-test.png', 'image/png')
        patch figura_disciplina_path(id), params: {disciplina: {file: arq}}
    end
    
    def testa_nao_mostra_links
        get curso_path(1)
        expect(response.body).not_to match(/<a(.*)>Nova disciplina<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Editar<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Excluir<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Figura<\/a>/)
    end
    
    def testa_mostra_links
        get curso_path(1)
        expect(response.body).to match(/<a(.*)>Nova disciplina<\/a>/)
        expect(response.body).to match(/<a(.*)>Editar<\/a>/)
        expect(response.body).to match(/<a(.*)>Excluir<\/a>/)
        expect(response.body).to match(/<a(.*)>Figura<\/a>/)
    end
    
end
