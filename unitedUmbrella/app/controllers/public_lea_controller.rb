class PublicLeaController < ApplicationController
  def index
      @leas = PublicLea.all.sort
  end

  def show
      @aun = params[:id]
      @lea = PublicLea.find_by_aun(@aun)
      @invalid_auns = Array.new
      if @lea.nil?
        @invalid_auns.push(@aun)
      end
  end

  def viewschools
  	@leas = Array.new
    @invalid_auns = Array.new
  	request.query_parameters.each do |key,value|
      school = PublicLea.find_by_aun(value) 
      if school.nil?
        @invalid_auns.push(value)
      else
  		  @leas.push( school )
      end
  	end
  end
end
