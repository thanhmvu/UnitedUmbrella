class PublicLeaController < ApplicationController
  def index
      @leas = PublicLea.all.sort
  end

  def show
      @aun = params[:id]
      @lea = PublicLea.find_by_aun(@aun)
  end

  def viewschools
  	@leas = Array.new
  	@p = params
  	request.query_parameters.each do |key,value|
  		@leas.push( PublicLea.find_by_aun(value) )
  	end
  end
end
