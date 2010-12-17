class PagesController < ApplicationController
  before_filter :require_admin
  def index
    @pages = Page.all
  end
  
  def show
    @page = Page.find(:first, :conditions => {:slug => params[:id]})
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Successfully created page."
      redirect_to pages_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(:first, :conditions => {:slug => params[:id]})
  end
  
  def update
    @page = Page.find(:first, :conditions => {:slug => params[:id]})
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to pages_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(:first, :conditions => {:slug => params[:id]})
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to pages_url
  end
end
