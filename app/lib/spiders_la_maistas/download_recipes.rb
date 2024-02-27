class SpidersLaMaistas::DownloadRecipes < Tanakai::Base

    def self.process_with_several_urls(recipe_urls)
        @identifier_id = SiteIdentifier.where(identifier: "la_maistas").first_or_create&.id
        @name = "la_maistas download_recipes"
        @engine = :selenium_chrome
        #@start_urls = [Recipe.where(identifier: "la_maistas").first&.url]
        #@start_urls = Recipe.where(site_identifier_id: @identifier_id).where(about: nil).pluck(:encoded_url)
        @start_urls = recipe_urls
        @config = {
            user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
            before_request: { delay: 4..7 }
        }
        self.crawl!
    end

    def parse(response, url:, data: {})
        recipe = Recipe.where(encoded_url: url).first
        puts "recipe.id"
        puts recipe.id
        begin
            SpidersLaMaistas::SaveRecipes.execute(recipe, response)
            recipe.download_exceptions.destroy
        rescue Exception => e
            recipe.download_exceptions.create(exception_text: e.class)
        end
    end

end