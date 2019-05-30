class AddLinkToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :link, :string
  end
end
