class SpidersLaMaistas::SaveRecipes

    def self.execute(recipe, response)
        #Recipe.new(remote_main_photo_url: "https://www.lamaistas.lt/uploads/modules/recipes/thumb300x224/40640.jpg", site_identifier_id: 1)
        recipe.about = response.css(".authorAboutRecipeSegment").css(".authorsDescription.full").to_s
        ingredients = response.css(".ingredients")
        ingredients.search(".discounts-system-segment").remove
        recipe.ingredients = ingredients.to_s
        recipe.steps = response.css(".method").to_s
        if response.css(".bigImg img").present?
            recipe.remote_second_photo_url = response.css(".bigImg img").first["src"]
        else 
            recipe.video_link = response.css(".bigImg").css("iframe").first["src"]
        end
        recipe.save(validate: false)
    end

end