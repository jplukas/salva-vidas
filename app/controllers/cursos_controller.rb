class CursosController < ApplicationController
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

  private
  def curso_params
    params.require(:curso).permit(:nome, :desc)
  end
end
