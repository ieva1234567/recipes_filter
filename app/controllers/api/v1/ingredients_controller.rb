class Api::V1::IngredientsController < ApplicationController

    def index 
        render json: RawIngredient.all.pluck(:ingredient_name)
    end

end