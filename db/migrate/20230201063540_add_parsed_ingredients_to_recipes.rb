class AddParsedIngredientsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :parsed_ingredients, :text
  end
end
