class SpidersLaMaistas::RecipesCount < Tanakai::Base

    def self.process
        @name = "la_maistas recipes_count"
        @engine = :selenium_chrome
        @config = {
            #user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
            user_agent: "Chrome",
            before_request: { delay: 4..7 }
        }
        self.crawl!
    end

    def parse(response, url: , data: {})

        count = response.css('.recipesTitleSegment').text.tr('^0-9', '').to_i
        pages_count = (count/44) + 1
        urls = []
        pages_count.times do |i| 
        urls << url + "#{i+1}"
        end
        return urls
    end

end