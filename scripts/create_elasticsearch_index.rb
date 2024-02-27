###FOR CREATING ELASTIC SERACH INDEX USED IN APP###
###### load Rails.root.join('scripts') + "create_elasticsearch_index.rb" ######
index_settings = { number_of_shards: 1, number_of_replicas: 0 }
settings = { settings: { index: index_settings } }
SearchClient.indices.create(index: ApplicationConfig::ELASTIC_INDEX, body: settings)
MAPPINGS = JSON.parse(File.read("config/elasticsearch/mappings/recipes.json"), symbolize_names: true).freeze
SearchClient.indices.put_mapping(index: ApplicationConfig::ELASTIC_INDEX, body: MAPPINGS)