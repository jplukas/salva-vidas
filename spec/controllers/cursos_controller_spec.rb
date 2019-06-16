require 'rails_helper'
require './spec/support/autenticacao.rb'
require './spec/support/cenarios.rb'

RSpec.describe CursosController, type: [:request, :controller] do

    before :each do
        cria_cursos_e_disciplinas
        @dados = {nome: 'teste', desc: 'teste'}
    end
    
    it 'Mostra os cursos cadastrados' do
        get cursos_path
        expect(response.body).to include("Curso1")
        expect(response.body).to include("Curso2")
    end
    
    it 'Não deixa usuário não autenticado criar curso' do
        testa_impede_criar_curso
    end
    
    it 'Não deixa usuário comum criar curso' do
        sign_in cria_usuario
        testa_impede_criar_curso
    end
    
    it 'Deixa admin criar curso' do
        sign_in cria_admin
        tenta_criar_curso
        consulta = Curso.where(@dados)
        expect(consulta.count).to eq(1)
    end
    
    it 'Não deixa usuário não autenticado editar curso' do
        testa_impede_editar_curso
    end
    
    it 'Não deixa usuário comum editar curso' do
        sign_in cria_usuario
        testa_impede_editar_curso
    end
    
    it 'Deixa admin editar curso' do
        sign_in cria_admin
        tenta_editar_curso(1)
        curso = Curso.find(1)
        expect(curso.nome).to eq(@dados[:nome])
        expect(curso.desc).to eq(@dados[:desc])
    end
    
    it 'Não deixa usuário não autenticado excluir curso' do
        testa_impede_excluir_curso
    end
    
    it 'Não deixa usuário comum excluir curso' do
        sign_in cria_usuario
        testa_impede_excluir_curso
    end
    
    it 'Deixa admin excluir curso' do
        curso = Curso.create!(nome: 'Curso teste', desc: 'kkk')
        sign_in cria_admin
        tenta_excluir_curso(curso.id)
        consulta = Curso.find_by(id: curso.id)
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
        expect(response).to redirect_to(:cursos)
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
    
    def testa_impede_criar_curso
        tenta_criar_curso
        expect(response.status).to eq(302)
        consulta = Curso.where(@dados)
        expect(consulta.count).to eq(0)
    end
    
    def tenta_criar_curso
        post cursos_path, params: {curso: @dados}
    end
    
    def testa_impede_editar_curso
        tenta_editar_curso(1)
        expect(response.status).to eq(302)
        curso = Curso.find(1)
        expect(curso.nome).to eq('Curso1')
        expect(curso.desc).to eq('kkk')
    end
    
    def tenta_editar_curso(id)
        put curso_path(id), params: {curso: @dados}
    end
    
    def testa_impede_excluir_curso
        tenta_excluir_curso(1)
        consulta = Curso.all
        expect(consulta.count).to eq(2)
    end
    
    def tenta_excluir_curso(id)
        delete curso_path(id)
    end
    
    def testa_impede_upar_figura
        tenta_upar_figura(1)
        expect(response).not_to redirect_to(:cursos)
    end
    
    def tenta_upar_figura(id)
        arq = fixture_file_upload('files/upload-test.png', 'image/png')
        patch figura_curso_path(id), params: {curso: {file: arq}}
    end
    
    def testa_nao_mostra_links
        get cursos_path
        expect(response.body).not_to match(/<a(.*)>Novo curso<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Editar<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Excluir<\/a>/)
        expect(response.body).not_to match(/<a(.*)>Figura<\/a>/)
    end
    
    def testa_mostra_links
        get cursos_path
        expect(response.body).to match(/<a(.*)>Novo curso<\/a>/)
        expect(response.body).to match(/<a(.*)>Editar<\/a>/)
        expect(response.body).to match(/<a(.*)>Excluir<\/a>/)
        expect(response.body).to match(/<a(.*)>Figura<\/a>/)
    end
    
end
