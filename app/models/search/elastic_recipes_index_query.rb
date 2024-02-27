module Search

    class ElasticRecipesIndexQuery

        attr_accessor :included, :excluded, :site_identifier_id, :title

        def initialize(included: [], excluded: [], site_identifier_id: 0, title: "")
            @included = included&.to_enum&.to_h&.map { |key, value| value } || []
            @excluded = excluded&.to_enum&.to_h&.map { |key, value| value } || []
            @site_identifier_id = site_identifier_id
            @title = title
        end

        def elastic_query
            new_hash = {bool: {}}
            new_hash[:bool][:must] = []
            new_hash[:bool][:must] << form_array(array: included, key: :ingredients) if included.length > 0
            new_hash[:bool][:must] << form_array(array: title.split(" "), key: :title) if title.present?
            new_hash[:bool][:must] << {match: {site_identifier_id: site_identifier_id}}
            new_hash[:bool][:must_not] = form_array(array: excluded, key: :ingredients) if excluded.length > 0
            new_hash[:bool][:must] = new_hash[:bool][:must].flatten
            new_hash
        end

        def form_array(array: [], key: :"")
            new_array = array.map do |a|
                {match: {key => a}}
            end
            new_array
        end

    end

end