class MainController < ApplicationController

	def welcome		
	end

	def elements
	end

	def public_lea
		redirect_to(:controller => 'public_lea_controller')
	end
end
