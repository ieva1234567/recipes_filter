class AddPhotosToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :main_photo, :string
    add_column :recipes, :second_photo, :string
  end
end
