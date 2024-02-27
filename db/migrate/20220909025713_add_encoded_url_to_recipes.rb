class AddEncodedUrlToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :encoded_url, :string
  end
end
