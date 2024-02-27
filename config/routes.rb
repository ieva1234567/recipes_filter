Rails.application.routes.draw do
  get 'site/index'
  root 'site#index'
  namespace :api do
    namespace :v1 do
       get '/ingredients/index'
       get '/site_identifiers/index'
       get '/recipes/index'
       get '/recipe/:id', to: 'recipes#show'
       get '/mailings/send_please_contact_me_mail'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/sitemap', to: 'site#sitemap', defaults: {format: 'xml'}
  mount Sidekiq::Web => '/sidekiq'
  get '/*path' => 'site#index'
end
