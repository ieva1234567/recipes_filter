class RawIngredient < ApplicationRecord
  belongs_to :ingredient, optional: true

  def self.add_to_list(ingredients_array)
    ingredients_array.each do |ing| 
        self.create(ingredient_name: ing) unless self.find_by(ingredient_name: ing)
    end
  end

end
