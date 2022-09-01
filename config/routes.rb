Rails.application.routes.draw do
  root :to => "tasks#index"
  devise_for :users
  resources :tasks do
    resources :comments, only: [:create, :destroy]
    member do
      get :assign
      patch "assign" => "tasks#assign_update"
      post "done" => "tasks#done"
    end
  end
  get "complete_tasks" => "tasks#complete_tasks"
  resources :users, :only => [:index, :show]
  get "mypage" => "users#mypage"
  get "mytask" => "users#mytask"
  get "complete_mytasks" => "users#complete_mytasks"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
