class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.references :site_identifier, null: false, foreign_key: true
      t.string :title
      t.text :about
      t.text :url
      t.text :page_url
      t.text :ingredients
      t.text :steps
      t.string :image

      t.timestamps
    end
  end
end
