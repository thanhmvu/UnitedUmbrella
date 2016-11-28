class PublicLeaController < ApplicationController
  def index
      @leas = PublicLea.all.sort
  end

  def show
      @aun = params[:aun]
      @lea = PublicLea.find_by_aun(@aun)
  end
end
