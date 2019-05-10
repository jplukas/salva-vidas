Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root controller: :home, action: :index
  get '/materia/:id', controller: :materias, action: :exibir
end
