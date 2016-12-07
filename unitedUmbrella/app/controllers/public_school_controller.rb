class PublicSchoolController < ApplicationController
  def index
      @schools = PublicSchool.all.sort
  end

  def show
  end
end
