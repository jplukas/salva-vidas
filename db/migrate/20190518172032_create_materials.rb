class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :nome, null: false
      t.text :conteudo, null: false
      t.references :disciplina, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :materials, [:nome, :disciplina_id, :user_id]
  end
end
