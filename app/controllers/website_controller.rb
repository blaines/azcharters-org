class WebsiteController < ApplicationController
  
  layout "website"

  before_filter :authenticate_user!, :only => :dashboard
  
  def index
    @pages = Page.all
  end
  def page
    @page = Page.find(:first, :conditions => {:slug => params[:id]})
  end
  def dashboard
    @current_tab = :dashboard
    @user = current_user || current_admin
    render :layout => "application"
  end
  def news
    @posts = NewsPost.all(:sort => [[:created_at, :desc]])
  end
  
end
