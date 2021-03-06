class DisciplinasController < ApplicationController

  before_action :require_admin_privileges, 
      only: [:new, :edit, :create, :update, :destroy, :upload_form, :upload]
  before_action :authenticate_user!, only: [:bookmark]

  def index
    @curso= Curso.find(params[:curso_id])
    @disciplinas = @curso.disciplinas
    respond_to do |format|
      format.html
      format.json { render json: @disciplinas.map{|d| {nome: d.nome, id: d.id}} }
    end
  end

  def new
    @curso = Curso.find(params[:curso_id])
    @disciplina = @curso.disciplinas.build
  end

  def show
    @disciplina = Disciplina.find(params[:id])
  end

  def edit
    @disciplina = Disciplina.find(params[:id])
    @curso = @disciplina.curso
  end

  def create
    @disciplina = Disciplina.new(disciplina_params)
    @disciplina.curso_id = params[:curso_id]
    if @disciplina.save
      flash[:success] = "Cadastro realizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    redirect_to new_curso_disciplina_path(@disciplina.curso)
  end

  def update
    @disciplina = Disciplina.find(params[:id])
    if @disciplina.update_attributes(disciplina_params)
      flash[:success] = "Registro atualizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    redirect_to new_curso_disciplina_path(@disciplina.curso)
  end

  def destroy
    @disciplina = Disciplina.find(params[:id])
    url = url_for(@disciplina.curso)
    @disciplina.destroy
    redirect_to url
  end
  
  def bookmark
    query = {seguidor_id: current_user.id, seguido_id: params[:id]}
    existente = RelUserDisciplina.find_by(query)
    if existente != nil
        existente.destroy!
        render json: {bookmarked: false}
    else
        RelUserDisciplina.create!(query)
        render json: {bookmarked: true}
    end
  end
  
  def upload_form
    @disciplina = Disciplina.find(params[:id])
  end
  
  def upload
    disciplina = Disciplina.find(params[:id])
    figura = FiguraDisciplina.find_by(disciplina_id: params[:id])
    figura.destroy! if figura
    FiguraDisciplina.create! imagem: params[:disciplina][:file].read,
                             arquivo: params[:disciplina][:file].original_filename,
                             mimetype: params[:disciplina][:file].content_type,
                             disciplina_id: params[:id]
    redirect_to curso_disciplinas_path(disciplina.curso)
  end
  
  def figura
    figura = FiguraDisciplina.find_by(disciplina_id: params[:id])
    send_data(figura.imagem, type: figura.mimetype, filename: "#{figura.arquivo}", disposition: "inline")
  end

  private
  def disciplina_params
    params.require(:disciplina).permit(:nome, :desc)
  end
end
