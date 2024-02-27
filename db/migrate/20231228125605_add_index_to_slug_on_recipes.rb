class AddIndexToSlugOnRecipes < ActiveRecord::Migration[7.0]
  def change
    add_index :recipes, :slug, unique: true
  end
end
