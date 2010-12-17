class NewsPostsController < ApplicationController
  before_filter :require_admin
  def index
    @news_posts = NewsPost.all(:sort => [[:created_at, :desc]])
  end
  
  def tags
    @tags = NewsPost.tags.map {|a| a.map {|b| {:caption => b[0], :value => b[0]} } }.flatten
    puts @tags.inspect
    render :json => @tags
  end
  
  def show
    @news_post = NewsPost.find(:first, :conditions => {:slug => params[:id]})
  end
  
  def new
    @news_post = NewsPost.new
  end
  
  def create
    @news_post = NewsPost.new(params[:news_post])
    @news_post.user = current_user
    if @news_post.save
      flash[:notice] = "Successfully created news post."
      redirect_to @news_post
    else
      render :action => 'new'
    end
  end
  
  def edit
    @news_post = NewsPost.find(:first, :conditions => {:slug => params[:id]})
  end
  
  def update
    @news_post = NewsPost.find(:first, :conditions => {:slug => params[:id]})
    if @news_post.update_attributes(params[:news_post])
      flash[:notice] = "Successfully updated news post."
      redirect_to @news_post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @news_post = NewsPost.find(:first, :conditions => {:slug => params[:id]})
    @news_post.destroy
    flash[:notice] = "Successfully destroyed news post."
    redirect_to news_posts_url
  end
end
