class MainController < ApplicationController

	def welcome		
	end

	def elements
	end

	def view_public_by_aun
		redirect_to public_lea_path(:id => params[:aun])
	end
end
