module Search
  class TagSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :ingredients
  end
end
