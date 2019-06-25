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
          resources :bookmarks, only: [:create, :destroy]
        end
      end
    end
  end

  get '/perfil', to: 'static_pages#perfil'
  get '/bookmarks', to: 'static_pages#bookmarks'
  
  post '/voto-up', controller: :votos, action: :up
  post '/voto-down', controller: :votos, action: :down
  post '/voto-comentario-up', controller: :voto_comentario, action: :up
  post '/voto-comentario-down', controller: :voto_comentario, action: :down
  get '/busca', controller: :busca, action: :buscar
  post '/favoritar', controller: :disciplinas, action: :bookmark 
  get '/novo-material', controller: :materials, action: :new2
  get '/cursos/:id/figura', controller: :cursos, action: :figura, as: :figura_curso
  get '/cursos/:id/upload', controller: :cursos, action: :upload_form, as: :curso_upload
  patch '/cursos/:id/figura', controller: :cursos, action: :upload
  get '/disciplinas/:id/figura', controller: :disciplinas, action: :figura, as: :figura_disciplina
  get '/disciplinas/:id/upload', controller: :disciplinas, action: :upload_form, as: :disciplina_upload
  patch '/disciplinas/:id/figura', controller: :disciplinas, action: :upload
  
end
