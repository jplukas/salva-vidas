include ActiveRecord::Sanitization::ClassMethods

class BuscaController < ApplicationController

    def buscar
        @texto = sanitize_sql_like(params[:q])
        @materiais = Material.where("conteudo LIKE ?", "%#{@texto}%")
                 .or(Material.where("nome LIKE ?", "%#{@texto}%"))
        @disciplinas = Disciplina.where("desc LIKE ?", "%#{@texto}%")
                   .or(Disciplina.where("nome LIKE ?", "%#{@texto}%"))
        @cursos = Curso.where("desc LIKE ?", "%#{@texto}%")
              .or(Curso.where("nome LIKE ?", "%#{@texto}%"))
    end

end
