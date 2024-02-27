module Search
  class RecipeSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :ingredients, :title, :site_identifier_id
  end
end
