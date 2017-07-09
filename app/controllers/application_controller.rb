  class ApplicationController < ActionController::Base
  #helper_method :current_or_guest_user

  include Pundit
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # devise guess user handling public methods 
  # if user is logged in, return current_user, else return guest_user

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :member])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :member])
end

private



  #flash message for pundit errors
  def user_not_authorized
      flash[:warning] = t "You are not authorized to perform this action."
      root_path
  end

  if false
  def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s_underscore
      flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      redirect_to(request.referrer || root_path)
  end
  end

  # devise guess user handling private methods 
  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save!
    # end
  end

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end

end
