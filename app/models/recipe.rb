class Recipe < ApplicationRecord
  serialize :parsed_ingredients, Array
  mount_uploader :main_photo, AssetUploader
  mount_uploader :second_photo, AssetUploader
  belongs_to :site_identifier
  has_many :download_exceptions

  slug :slug

  validates_uniqueness_of :slug

  def fill_slug
    update(slug: title.parameterize + "-" + id.to_s)
  end

  def add_to_elasticsearch
    serialized_data = Search::RecipeSerializer.new(self).serializable_hash.dig(:data, :attributes)
    SearchClient.index(id: self.id, index: ApplicationConfig::ELASTIC_INDEX, body: serialized_data)
  end

  def parse_ingredients_and_add_to_list
    puts "recipe.id #{self.id}"
    return unless ingredients.present?
    self.update(parsed_ingredients: ParseIngredients.new(site_identifier.identifier, ingredients).ingredients)
    RawIngredient.add_to_list(parsed_ingredients) if self.parsed_ingredients.present?
  end

  def self.search_example
    SearchClient.search(q: 'raudonieji -greipfrutai')
  end

end
