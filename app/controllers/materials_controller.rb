class MaterialsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @disciplina = Disciplina.find(params[:disciplina_id])
    @materials = Array.new
    score = Voto.group(:material_id).sum(:sinal)
    unrated = @disciplina.materials.pluck(:id) - score.keys
    unrated.each { |x| score[x] = 0 }
    score = score.sort_by {|k, v| v}.reverse.to_h
    score.each do |id, s|
      mat = Material.find(id)
      if mat.disciplina_id == params[:disciplina_id].to_i
        @materials.push(mat)
      end
    end
  end

  def new
    @disciplina = Disciplina.find(params[:disciplina_id])
    @material = @disciplina.materials.build
  end

  def new2
    @cursos = Curso.order(:nome)
    @disciplina = @cursos[0].disciplinas[0]
    @material = @disciplina.materials.build
  end

  def show
    @material = Material.find(params[:id])
    @autor = @material.user
    @comentarios = @material.comentarios
    # @newcom = @material.comentarios.build
  end

  def edit
    @material = Material.find(params[:id])
    @disciplina = @material.disciplina
  end

  def create
    @material = Material.new(material_params)
    @material.disciplina_id ||= params[:disciplina_id]
    @material.user_id = current_user.id
    if not @material.link.start_with?("http://", "https://")
      @material.link = "http://#{@material.link}"
    end
    if @material.save
      flash[:success] = "Cadastro realizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    redirect_to new_disciplina_material_path(@material.disciplina)
  end

  def update
    @material = Material.find(params[:id])
    if @material.update_attributes(material_params)
      flash[:success] = "Registro atualizado!"
    else
      flash[:danger] = "A ação não pôde ser realizada."
    end
    redirect_to material_path(@material)
  end

  def destroy
    @material = Material.find(params[:id])
    url = url_for(@material.disciplina)
    @material.destroy
    redirect_to url
  end

  private
  def material_params
    params.require(:material).permit(:nome, :conteudo, :link, :disciplina_id)
  end
end
