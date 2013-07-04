class ApplicationController < ActionController::Base
  protect_from_forgery

  def unauthorized(message = nil)
    @message = message
    respond_to do |format|
      format.html { render :template => "errors/unauthorized", :status => 401 }
      format.xml do
        headers["WWW-Authenticate"] = %(Basic realm="Web Password")
        render :nothing => true, :status => 401
      end
      format.all { render :nothing => true, :status => 401 }
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  helper_method :current_user, :logged_in?

  def check_logged_in
    unless logged_in?
      unauthorized('Please log in.')
    end
  end
end
