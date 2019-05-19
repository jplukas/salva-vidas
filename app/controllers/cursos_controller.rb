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
end
