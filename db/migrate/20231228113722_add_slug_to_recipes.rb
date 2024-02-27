class AddSlugToRecipes < ActiveRecord::Migration[7.0]
  def up
    add_column :recipes, :slug, :string
  end

  def down
    remove_column :recipes, :slug, :string
  end
end
