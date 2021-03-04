class AddNameToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :name, :string
  end
end
