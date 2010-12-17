class MarketplacePostsController < ApplicationController
  before_filter :authenticate_user!
  def index
    m = MarketplacePost
    p = params
    p.delete("controller")
    p.delete("action")
    conditions = []
    conditions << m.where(:zip => p[:zip]) unless p[:zip].blank?
    c = m.criteria
    c = c.any_of({:title => /.*#{p[:q]}.*/mi}, {:body => /.*#{p[:q]}.*/mi}) unless p[:q].blank?
    c = c.and(:price_in_cents.gt => p[:price_from].to_i*100) unless p[:price_from].blank?
    c = c.and(:price_in_cents.lt => p[:price_to].to_i*100) unless p[:price_to].blank?
    conditions << c
    # conditions << m.where() if p[:q]
    conditions.blank? ? @marketplace_posts = m.all : @marketplace_posts = conditions.sum
  end
  
  def show
    @marketplace_post = MarketplacePost.find(params[:id])
  end
  
  def new
    @marketplace_post = MarketplacePost.new
  end
  
  def create
    @marketplace_post = MarketplacePost.new(params[:marketplace_post])
    @marketplace_post.user = current_user
    if @marketplace_post.save
      flash[:notice] = "Successfully created marketplace post."
      redirect_to @marketplace_post
    else
      render :action => 'new'
    end
  end
  
  def edit
    @marketplace_post = MarketplacePost.find(params[:id])
  end
  
  def update
    @marketplace_post = MarketplacePost.find(params[:id])
    if @marketplace_post.update_attributes(params[:marketplace_post])
      flash[:notice] = "Successfully updated marketplace post."
      redirect_to @marketplace_post
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @marketplace_post = MarketplacePost.find(params[:id])
    @marketplace_post.destroy
    flash[:notice] = "Successfully destroyed marketplace post."
    redirect_to marketplace_posts_url
  end
end
