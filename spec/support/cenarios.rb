module CenariosHelpers

    def cria_cursos_e_disciplinas
        c1 = Curso.create! nome: 'Curso1', desc: 'kkk'
        Disciplina.create! curso: c1, nome: 'Disc1-c1', desc: 'kkk'
        Disciplina.create! curso: c1, nome: 'Disc2-c1', desc: 'kkk'
        c2 = Curso.create! nome: 'Curso2', desc: 'kkk'
        Disciplina.create! curso: c2, nome: 'Disc3-c2', desc: 'kkk'
        Disciplina.create! curso: c2, nome: 'Disc4-c2', desc: 'kkk'
    end
    
    def cria_material(conteudo, user, disciplina)
        Material.create! nome: conteudo, disciplina: disciplina, user: user, conteudo: conteudo
    end

end

RSpec.configure do |c|
  c.include CenariosHelpers
end

