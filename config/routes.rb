Rails.application.routes.draw do
  root to: 'session_histories#index'
  get '*path', to: 'session_histories#index'
end
