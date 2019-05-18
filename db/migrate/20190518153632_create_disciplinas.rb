class CreateDisciplinas < ActiveRecord::Migration[5.2]
  def change
    create_table :disciplinas do |t|
      t.string :nome
      t.text :desc
      t.references :curso, foreign_key: true

      t.timestamps
    end
    add_index :disciplinas, :nome
  end
end
