Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  shallow do
    resources :cursos do
      resources :disciplinas do
        resources :materials do
          resources :comentarios, only: [:create, :destroy]
          resources :votos, only: [:create, :update, :destroy]
        end
      end
    end
  end
  
  post '/voto-up', controller: :votos, action: :up
  post '/voto-down', controller: :votos, action: :down
  post '/voto-comentario-up', controller: :voto_comentario, action: :up
  post '/voto-comentario-down', controller: :voto_comentario, action: :down
  
end
