class ApplicationController < ActionController::Base
  protect_from_forgery
  #require 'opengraph'
  #before_filter { |c| Authorization.current_user = c.current_user }
  before_filter :authorize , :only => [:moderation] #:except =>[:sign_in]
  
  protected
  
  def authorize
   unless Auteur.find_by_id(session[:user_id])
     #flash[:warning] = "Veuillez-vous identifier !"
     redirect_to(:controller=> "home", :action=> "index")
   end
   return true
  end

  protected

  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
end
