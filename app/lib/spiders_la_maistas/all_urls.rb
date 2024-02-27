class SpidersLaMaistas::AllUrls < Tanakai::Base

    def self.process
        @name = "la_maistas all_urls"
        @engine = :selenium_chrome
        @start_urls = ["https://www.lamaistas.lt/visi-receptai/"]
        @start_urls = SpidersLaMaistas::RecipesCount.parse!(:parse, url: "https://www.lamaistas.lt/visi-receptai/")
        @config = {
            user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
            before_request: { delay: 4..7 }
        }
        self.crawl!
    end

    def parse(response, url:, data: {})
        identifier_id = SiteIdentifier.where(identifier: "la_maistas").first_or_create&.id
        response.css(".cell.sDef-4.s1280-4.s1024-3.s760-3.s460-2.s320-2 a").each do |a| 
        r = Recipe.where(url: a["href"], site_identifier_id: identifier_id)
        next if r.first&.title.present?
        r = r.first_or_create
        r.update(image: a.css(".image img").first["src"], title: a.css(".title").text().strip,
            encoded_url: URI.encode(r.url))
        end
    end

end