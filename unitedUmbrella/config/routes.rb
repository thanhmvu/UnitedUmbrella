Rails.application.routes.draw do
  	root 'main#welcome'

  	resources :public_lea, :only => [:index, :show] # make the request RESTful
  	get 'main/welcome'
  	get 'main/elements'
	# get 'public_lea/index'
#  get 'public_lea/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
