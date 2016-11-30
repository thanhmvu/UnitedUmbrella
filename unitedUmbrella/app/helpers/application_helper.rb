module ApplicationHelper
	def show_error_message(message)
		render(:partial => 'main/error_message', :locals => {:error_message => message})
	end
end
