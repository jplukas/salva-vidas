class DisciplinasController < ApplicationController
  def index
    @curso= Curso.find(params[:curso_id])
    @disciplinas = @curso.disciplinas
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

  private
  def disciplina_params
    params.require(:disciplina).permit(:nome, :desc)
  end
end
