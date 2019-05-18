class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :titulo
      t.text :descricao
      t.string :arquivo
      t.string :link
      t.references :disciplina, foreign_key: true

      t.timestamps
    end
  end
end
