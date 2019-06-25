class CursosController < ApplicationController

  before_action :require_admin_privileges, 
      only: [:new, :edit, :create, :update, :destroy, :upload_form, :upload]

  def index
    @cursos = Curso.all
  end

  def new
    @curso = Curso.new
  end

  def show
    @curso = Curso.find(params[:id])
    @disciplinas = @curso.disciplinas
  end

  def edit
    @curso = Curso.find(params[:id])
  end

  def create
    @curso = Curso.new(curso_params)
    if @curso.save
      flash[:success] = "Cadastro realizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    render 'new'
  end

  def update
    @curso = Curso.find(params[:id])
    if @curso.update_attributes(curso_params)
      flash[:success] = "Registro atualizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    render 'edit'
  end

  def destroy
    @curso = Curso.find(params[:id])
    @curso.destroy
    redirect_to '/cursos'
  end
  
  def upload_form
    @curso = Curso.find(params[:id])
  end
  
  def upload
    curso = Curso.find(params[:id])
    figura = FiguraCurso.find_by(curso_id: params[:id])
    figura.destroy! if figura
    FiguraCurso.create! imagem: params[:curso][:file].read,
                        arquivo: params[:curso][:file].original_filename,
                        mimetype: params[:curso][:file].content_type,
                        curso_id: params[:id]
    redirect_to cursos_path
  end
  
  def figura
    figura = FiguraCurso.find_by(curso_id: params[:id])
    send_data(figura.imagem, type: figura.mimetype, filename: "#{figura.arquivo}", disposition: "inline")
  end

  private
  def curso_params
    params.require(:curso).permit(:nome, :desc)
  end
end
