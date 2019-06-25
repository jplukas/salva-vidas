class CreateFiguraCursos < ActiveRecord::Migration[5.2]
  def change
    create_table :figura_cursos do |t|
      t.string :arquivo
      t.binary :imagem
      t.string :mimetype
      t.references :curso

      t.timestamps
    end
  end
end
