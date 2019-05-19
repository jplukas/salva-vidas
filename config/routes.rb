Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  shallow do
    resources :cursos do
      resources :disciplinas do
        resources :materials do
          resources :comentarios, only: [:create, :destroy]
        end
      end
    end
  end
end
