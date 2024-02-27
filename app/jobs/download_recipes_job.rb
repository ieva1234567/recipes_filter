class DownloadRecipesJob < ApplicationJob

    def perform
        Recipe.where(about: nil).pluck(:encoded_url).in_groups_of(100).compact.each do |recipe_urls|
            SpidersLaMaistas::DownloadRecipes.process_with_several_urls(recipe_urls)
        end
    end

end