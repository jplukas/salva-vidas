class AddCursoRefToDisciplina < ActiveRecord::Migration[5.2]
  def change
    add_reference :disciplinas, :curso, foreign_key: true
  end
end
