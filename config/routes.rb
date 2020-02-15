Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/v1' do
    scope '/auth' do
      post '/signin' => 'auth#signin'
      post '/signup' => 'auth#signup'
    end
    scope 'user' do
      get '' => 'user#all'
      get '/:personId' => 'user#detail'
    end
  end
end
