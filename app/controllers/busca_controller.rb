include ActiveRecord::Sanitization::ClassMethods

class BuscaController < ApplicationController

    def buscar
        @texto = sanitize_sql_like(params[:q])
        @materiais = Material.where("materials.conteudo LIKE ?", "%#{@texto}%")
                 .or(Material.where("materials.nome LIKE ?", "%#{@texto}%"))
        @disciplinas = Disciplina.where("disciplinas.desc LIKE ?", "%#{@texto}%")
                   .or(Disciplina.where("disciplinas.nome LIKE ?", "%#{@texto}%"))
        @cursos = Curso.where("cursos.desc LIKE ?", "%#{@texto}%")
              .or(Curso.where("cursos.nome LIKE ?", "%#{@texto}%"))
    end

end
