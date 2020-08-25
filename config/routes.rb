Rails.application.routes.draw do
  resources :folders do
    resources :files, only: [:create, :destroy]
  end

  root to: 'folders#index'
end
