# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :set_current_tab
  def authenticate_admin!
    true if authenticate_user! and current_user.admin?
  end
  def require_admin
    flash[:notice] = "Access Denied"
    redirect_to :dashboard
  end
  
  protected
  def set_current_tab
    AzchartersOrg::Application.i
    # will default to controller_name if @current_tab
    # has not been set by another controller
    @current_tab ||= self.controller_name.to_sym
  end
end
