class SchoolAssessmentResultsController < ApplicationController
  	def index
  	end

  	def show
	    @invalid_ids = Array.new
		@school = SchoolAssessmentResults.find_by(school_id: params[:id])
	end
end
