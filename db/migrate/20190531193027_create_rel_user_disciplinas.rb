class CreateRelUserDisciplinas < ActiveRecord::Migration[5.2]
  def change
    create_table :rel_user_disciplinas do |t|
      t.integer :seguidor_id
      t.integer :seguido_id

      t.timestamps
    end
    add_index :rel_user_disciplinas, :seguido_id
    add_index :rel_user_disciplinas, :seguidor_id
    add_index :rel_user_disciplinas, [:seguido_id, :seguidor_id], unique: true
  end
end
