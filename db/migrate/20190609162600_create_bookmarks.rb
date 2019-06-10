class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :material_id

      t.timestamps
    end
    add_index :bookmarks, :user_id
    add_index :bookmarks, :material_id
    add_index :bookmarks, [:user_id, :material_id], unique: true
  end
end
