get 'errors/error_404'
match '*not_found', to: 'errors#error_404', via: [:post, :get, :put, :patch, :delete]
