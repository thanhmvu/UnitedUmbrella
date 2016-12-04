class PrivateSchoolsElementaryEnrollmentController < ApplicationController
    def index
        #        @schools = PublicSchoolEnrollment.all#.sort
        @schools = PrivateSchoolsElementaryEnrollment.where(:aun => "200000000")
    end

    def show
	@aun = params[:aunid]
        @schools = PrivateSchoolsElementaryEnrollment.where(:aun => @aun)        
    end


    def compare_elementary_enrollment
        auns = Array.new
        @invalid_auns = Array.new

        # save all the valid auns into a list
        request.query_parameters.values.each do |aunid|
                school_data = PrivateSchoolsElementaryEnrollment.find_by(aun: aunid)
                if school_data.nil?
                        @invalid_auns.push( aunid )
                else
                        auns.push( aunid )
                end
        end

        if @invalid_auns.empty?
                @all_data = Hash.new
                auns.each do |aunid|
                        # find the school name based on aun
                        school = PrivateSchoolsEnrollment.find_by(aun: aunid)

                        # get the tuples (end year, total) of the school
                        school_data = PrivateSchoolsElementaryEnrollment.where(:aun => aunid).select("academic_year_end", "totalee")
                        @all_data[school.name] = school_data
                end
        end
    end
end

