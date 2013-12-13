Tazk::Application.routes.draw do
  
  resources :stages
  resources :tasks do
    resources :comments, controller: "task/comments"
  end
  
  
  root to: 'tasks#index'
end
