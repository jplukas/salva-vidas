class CreateVotoComentarios < ActiveRecord::Migration[5.2]
  def change
    create_table :voto_comentarios do |t|
      t.references :comentario, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :sinal
      t.timestamps
    end
  end
end
