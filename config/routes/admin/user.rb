resources :users do
  collection do
    get :edit_profile
    patch :update_profile
  end
end
