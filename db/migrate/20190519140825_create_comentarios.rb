class CreateComentarios < ActiveRecord::Migration[5.2]
  def change
    create_table :comentarios do |t|
      t.text :conteudo
      t.references :user, foreign_key: true
      t.references :material, foreign_key: true

      t.timestamps
    end
  end
end
