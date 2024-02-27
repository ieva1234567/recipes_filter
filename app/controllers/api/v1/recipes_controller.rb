class Api::V1::RecipesController < ApplicationController
    
    def index 
        final_string_query = params["fQuery"]
        if final_string_query.present? && (final_string_query["included"].present? || 
            final_string_query["excluded"].present? || final_string_query["includedPhrase"].present?)
            elastic_query = Search::ElasticRecipesIndexQuery.new(included: final_string_query["included"],
                excluded: final_string_query["excluded"], 
                site_identifier_id: SiteIdentifier.find_by_identifier(params["sIdentifier"])&.id,
                title: final_string_query["includedPhrase"]).elastic_query
            puts "elastic_query: #{elastic_query}"
            result = SearchClient.search(index: ApplicationConfig::ELASTIC_INDEX, body: { query: elastic_query, size: 1000 })
            recipes_ids = result["hits"]["hits"].map{|array| array["_id"]}
            recipes = Recipe.where(id: recipes_ids)
        else
            recipes = Recipe.where(site_identifier_id: SiteIdentifier.find_by_identifier(params["sIdentifier"])&.id)
        end
        recipes_paged = recipes.order(updated_at: :desc).paginate(page: params[:page], per_page: 50)
        render json: recipes_paged
    end

    def show
        recipe = Recipe.find_by_slug(params[:id])
        render json: recipe
    end

end