class MaterialsController < ApplicationController
  def index
    @disciplina = Disciplina.find(params[:disciplina_id])
    @materials = @disciplina.materials
  end

  def new
    @disciplina = Disciplina.find(params[:disciplina_id])
    @material = @disciplina.materials.build
  end

  def show
    @material = Material.find(params[:id])
  end

  def edit
    @material = Material.find(params[:id])
    @disciplina = @material.disciplina
  end

  def create
    @material = Material.new(material_params)
    @material.disciplina_id = params[:disciplina_id]
    @material.user_id = current_user.id
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
    redirect_to new_disciplina_material_path(@material.disciplina)
  end

  def destroy
    @material = Material.find(params[:id])
    url = url_for(@material.disciplina)
    @material.destroy
    redirect_to url
  end

  private
  def material_params
    params.require(:material).permit(:nome, :conteudo)
  end
end