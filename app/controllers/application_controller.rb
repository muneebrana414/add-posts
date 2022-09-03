class ApplicationController < ActionController::Base
	include Pundit::Authorization
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	private

	def user_not_authorized
		flash[:notice] = "You are not authorized."
		redirect_to(request.referrer || root_path)
	end
end
