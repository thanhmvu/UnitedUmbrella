class PublicSchoolEnrollmentController < ApplicationController
    def index
#        @schools = PublicSchoolEnrollment.all#.sort
        @schools = PublicSchoolEnrollment.where(:aun => "124150002")
    end
    
    def show
        @aun = params[:id]
        @schools = PublicSchoolEnrollment.where(:aun => @aun)
    end


    def compare_schools
    	ids = Array.new
    	@invalid_ids = Array.new

    	# save all the valid ids into a list
    	request.query_parameters.values.each do |id|
    		school_data = PublicSchoolEnrollment.find_by(school_id: id)
    		if school_data.nil?
    			@invalid_ids.push( id )
    		else
    			ids.push( id )
    		end   		
    	end

    	if @invalid_ids.empty?
    		@all_data = Hash.new
    		ids.each do |id|
    			# find the school name based on ID
    			school = PublicSchool.find_by(school_id: id)

    			# get the tuples (end year, total) of the school
    			school_data = PublicSchoolEnrollment.where(:school_id => id).select("academic_year_end", "total")
    			@all_data[school.school_name] = school_data
    		end
    	end
    end
end
