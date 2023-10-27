class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      @error = "User not authorized to perform this action"
      flash[:error] = @error
      redirect_to controller: "products", action: "new"
    end
end
