class AddVideoLinkToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :video_link, :string
  end
end
