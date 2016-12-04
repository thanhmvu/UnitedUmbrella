class PublicSchoolGenderEnrollmentController < ApplicationController
	def index
	end

	def show
	end

	def compare
		ids = Array.new
		@invalid_ids = Array.new

		# A local function to check if string is a number
		def is_number? string
		  true if Float(string) rescue false
		end

		# save all the valid ids into a list
		request.query_parameters.values.each do |param|
			if is_number?(param)
				id = param
				school_data = PublicSchoolGenderEnrollment.find_by(school_id: id)
				if school_data.nil?
					@invalid_ids.push( id )
					puts "======> invalid id: #{id}"
				else
					ids.push( id )
					puts "======> valid id: #{id}"
				end   	
			else
				@gender = param
			end	
		end

		if @invalid_ids.empty?
			@all_data = Hash.new
			ids.each do |id|
				# find the school name based on ID
				school = PublicSchool.find_by(school_id: id)

				# get the tuples (end year, total) of the school
				school_data = PublicSchoolGenderEnrollment.where(:school_id => id, :gender => @gender).select("academic_year_end", "total")
				@all_data[school.school_name] = school_data
			end
		end
	end
end
