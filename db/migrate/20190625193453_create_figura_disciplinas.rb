class CreateFiguraDisciplinas < ActiveRecord::Migration[5.2]
  def change
    create_table :figura_disciplinas do |t|
      t.string :arquivo
      t.binary :imagem
      t.string :mimetype
      t.references :disciplina

      t.timestamps
    end
  end
end
