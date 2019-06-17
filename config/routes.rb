Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
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
  
  post '/voto-up', controller: :votos, action: :up
  post '/voto-down', controller: :votos, action: :down
  post '/voto-comentario-up', controller: :voto_comentario, action: :up
  post '/voto-comentario-down', controller: :voto_comentario, action: :down
  get '/busca', controller: :busca, action: :buscar
  post '/favoritar', controller: :disciplinas, action: :bookmark 
  get '/novo-material', controller: :materials, action: :new2
  get '/cursos/:id/figura', controller: :cursos, action: :upload_form, as: :figura_curso
  patch '/cursos/:id/figura', controller: :cursos, action: :upload
  get '/disciplinas/:id/figura', controller: :disciplinas, action: :upload_form, as: :figura_disciplina
  patch '/disciplinas/:id/figura', controller: :disciplinas, action: :upload
  
end
