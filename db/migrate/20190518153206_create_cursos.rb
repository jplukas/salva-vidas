class CreateCursos < ActiveRecord::Migration[5.2]
  def change
    create_table :cursos do |t|
      t.string :nome, null: false
      t.text :desc

      t.timestamps
    end
    add_index :cursos, :nome
  end
end
