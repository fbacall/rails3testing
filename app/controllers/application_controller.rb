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

  def logged_in?
    user_signed_in?
  end

  helper_method :logged_in?

  def check_logged_in
    unless logged_in?
      unauthorized('Please log in.')
    end
  end
end
