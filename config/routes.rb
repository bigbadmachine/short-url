Rails.application.routes.draw do
  root 'links#new'
  
  get '/:token' => 'links#show', :as => 'link' 
  get '/' => 'links#new', :as => 'new_link' 
  post '/' => 'links#create', :as => 'links'
end
