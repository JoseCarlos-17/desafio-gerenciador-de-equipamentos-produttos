Rails.application.routes.draw do
  resources :equipment do
    get '/equipment_type_options', on: :collection, to: 'equipment#equipment_type_options'
  end
  resources :locations, only: %i[index create]
end
