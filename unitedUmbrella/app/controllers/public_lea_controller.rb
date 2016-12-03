class PublicLeaController < ApplicationController
  def index
      @leas = PublicLea.all.sort
      @lea_map = PublicLea.order("lea_type").group("lea_type").count
  end

  def show
      @aun = params[:id]
      @lea = PublicLea.find_by(aun: @aun)
      @invalid_auns = Array.new
      if @lea.nil?
        @invalid_auns.push(@aun)
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
