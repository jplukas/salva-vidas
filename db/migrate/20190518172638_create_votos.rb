class CreateVotos < ActiveRecord::Migration[5.2]
  def change
    create_table :votos do |t|
      t.references :material, foreign_key: true
      t.references :user, foreign_key: true
      t.binary :up, null: false

      t.timestamps
    end
  end
end
