Rails.application.routes.draw do


  get 'public_school_gender_enrollment/index'

  get 'public_school_gender_enrollment/show'

  get 'public_school_gender_enrollment/compare'

    # ======================== MAIN ======================== #
  	root 'main#welcome'
  	get 'main/welcome'
  	get 'main/elements'
    get 'main/view_public_by_aun'
    get 'main/view_public_by_lea'
    get 'public_lea/viewschools'
    get 'public_school_enrollment/compare_schools'
    get 'private_schools_elementary_enrollment/compare_elementary_enrollment'
    
    # ======================== PUBLIC SCHOOL DATABASE ======================== #
    resources :public_lea, :only => [:index, :show] # make the request RESTful
    # get 'public_lea/index'
    # get 'public_lea/show'
    resources :public_school_enrollment, :only => [:index, :show]
    resources :public_school, :only => [:index, :show]
    resources :school_assessment_results, :only => [:index, :show]
    # get 'school_assessment_results/index'
    # get 'school_assessment_results/show'
    
    
    # ======================== PRIVATE SCHOOL DATABASE ======================== #
    resources :private_schools_elementary_enrollment, :only => [:index, :show]
    
    
    # ======================== SCHOOL ASSESSMENT DATABASE ======================== #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
