class VotosFix < ActiveRecord::Migration[5.2]
  def change
    remove_column :votos, :up
    add_column :votos, :sinal, :integer
  end
end
