class ApplicationController < ActionController::Base
  protect_from_forgery

  def autocomplete

  end

  def unauthorized(message = nil)
    @message = message
    respond_to do |format|
      format.html { render :template => "errors/unauthorized", :status => 401 }
      format.all { render :nothing => true, :status => 401 }
    end
  end

  private

  def current_user
    ActiveSupport::XmlMini.backend = 'LibXML'
    Hash.from_xml('<a>b</a>')
    @current_user ||= User.find(session[:user_id], :include => :groups) if session[:user_id]
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
