class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      dynamic_controller = policy_name.split("_")[0]
      flash[:error] = "#{policy_name}.#{exception.query} not allowed for your role"
      redirect_back(fallback_location: root_path)
    end
end
