class MainController < ApplicationController

	def welcome	
		@leas = PublicLea.all.sort_by {|s| s.lea_name}	
	end

	def elements
	end

	def view_public_by_aun
		redirect_to public_lea_path(:id => params[:aun])
	end

	def view_public_by_lea
		redirect_to public_school_enrollment_path(:id => params[:aun])
	end
end
