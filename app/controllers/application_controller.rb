class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def require_user_logged_in
    redirect_to login_url unless logged_in?
  end
  def counts(user)
    @count_microposts = user.microposts.count
  end
end
