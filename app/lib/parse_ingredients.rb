class ParseIngredients 

    attr_reader :identifier, :raw_ingredients
    attr_accessor :ingredients

    def initialize(identifier, raw_ingredients)
        @raw_ingredients = raw_ingredients
        case identifier
        when "la_maistas"
            parse_for_la_maistas
        end
    end

    def parse_for_la_maistas
        doc = Nokogiri::HTML(raw_ingredients)
        if doc.css(".infoA").css(".ingredient").present?
            ingredients_without_quantities = []
            doc.css(".infoA").css(".ingredient").text.split("\n").reject!(&:blank?).compact.each do |a|
                splitted_string = a.gsub(/\(.*?\)/, '').split(',')
                if splitted_string.present?
                    final_str = splitted_string[0]&.split('(')[0]&.strip
                    ingredients_without_quantities << remove_quantity(final_str).strip if final_str.present?
                end
            end
            @ingredients = ingredients_without_quantities.reject(&:blank?)
            #@ingredients = remove_quantity_from_ingredients(ingredients_with_quantities)
        elsif doc.css(".infoA").css("#adform").present?
            @ingredients = remove_quantity_from_ingredients(doc.css(".infoA").css("#adform").first["data-ingredients"].split(",").map do |a|
                a.strip
            end)
        elsif doc.css(".infoA").css(".ingradientai-item").present?
            @ingredients = doc.css(".infoA").css(".ingradientai-item")[1..-1].map do |iwq|
                remove_quantity(iwq.text).strip
            end.compact
        else
            nil
        end
    end

    def remove_quantity_from_ingredients(array)
        array.map do |iwq|
            remove_quantity(iwq).strip
        end.compact
    end

    def remove_quantity(word)
        new_word = if word.index("g ")
            word[word.index("g ")+2..-1]
        elsif word.index(" g ")
            word[word.index(" g ")+3..-1]
        elsif word.index("a. š. ")
            word[word.index("a. š. ")+6..-1]
        elsif word.index("šaukštai")
            word[word.index("šaukštai")+8..-1]
        elsif word.index("stiklinės")
            word[word.index("stiklinės")+9..-1]
        elsif word.index(/\d+/)
            while word.index(/\d+/)
                word = word[word.index(/\d+/)+1..-1]
            end
            word
        elsif word.index("kg ")
            word[word.index("kg ")+2..-1]
        else
            word
        end
        new_word
    end

end