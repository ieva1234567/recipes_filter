class AddToElasticsearchJob < ApplicationJob

    def perform
        Recipe.where.not(ingredients: nil).each do |recipe|
            recipe.add_to_elastic_search
        end
    end

end