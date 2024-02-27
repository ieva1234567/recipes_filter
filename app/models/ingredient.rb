class Ingredient < ApplicationRecord

    validates :ingredient, uniqueness: true

    def create_from_recipes
        
    end

end

