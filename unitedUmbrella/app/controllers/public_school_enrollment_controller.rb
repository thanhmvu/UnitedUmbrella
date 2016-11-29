class PublicSchoolEnrollmentController < ApplicationController
    def index
#        @schools = PublicSchoolEnrollment.all#.sort
        @schools = PublicSchoolEnrollment.where(:aun => "124150002")
    end
    
    def show
        @aun = params[:id]
        @schools = PublicSchoolEnrollment.where(:aun => @aun)
    end

end
