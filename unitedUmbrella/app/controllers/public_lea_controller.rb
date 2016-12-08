class PublicLeaController < ApplicationController
  def index
      @leas = PublicLea.all.sort
      @lea_map = PublicLea.order("lea_type").group("lea_type").count
  end

  def show
      @aun = params[:id]
      @invalid_auns = Array.new
      # find all school_ids with the input aun
      @school_ids = PublicSchool.where(:aun => @aun).select("school_id")
      if @school_ids.empty?
        @invalid_auns.push( @aun )
      else
        # get an array of School tuples from the ids
        @schools = Array.new
        @school_names = Array.new
        @school_ids.each do |id|
          @schools.push( SchoolAssessmentResults.find_by(school_id: id.school_id) )
          @school_names.push( PublicSchool.find_by(school_id: id.school_id) )
        end
      end
  end

  def viewschools
  	@leas = Array.new
    @invalid_auns = Array.new
  	request.query_parameters.values.each do |value|
      school = PublicLea.find_by(aun: value) 
      if school.nil?
        @invalid_auns.push(value)
      else
  		  @leas.push( school )
      end
  	end
  end
end
