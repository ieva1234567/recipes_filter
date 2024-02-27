class CreateRawIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :raw_ingredients do |t|
      t.string :ingredient_name
      t.references :ingredient, null: true, foreign_key: true

      t.timestamps
    end
  end
end
