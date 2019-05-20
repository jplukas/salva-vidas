class DisciplinasController < ApplicationController
  def index
  end

  def new
    @curso = Curso.find(params[:curso_id])
    @disciplina = @curso.disciplinas.build
  end

  def show
    @disciplina = Disciplina.find(params[:id])
  end

  def edit
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

  private
  def disciplina_params
    params.require(:disciplina).permit(:nome, :desc)
  end
end
