class SearchesController < ApplicationController
  before_filter :authenticate_user!
  def show
    p = params
    p.delete("controller")
    p.delete("action")
    e = Event
    m = MarketplacePost
    g = Page
    n = NewsPost
    
    e = e.any_of({:name => /.*#{p[:q]}.*/mi}, {:description => /.*#{p[:q]}.*/mi}) unless p[:q].blank?
    m = m.any_of({:title => /.*#{p[:q]}.*/mi}, {:body => /.*#{p[:q]}.*/mi}) unless p[:q].blank?
    g = g.any_of({:title => /.*#{p[:q]}.*/mi}, {:body => /.*#{p[:q]}.*/mi}) unless p[:q].blank?
    n = n.any_of({:title => /.*#{p[:q]}.*/mi}, {:body => /.*#{p[:q]}.*/mi}) unless p[:q].blank?
    
    @results = [] if p[:q].blank?
    @results ||= (e.to_a+m.to_a+g.to_a+n.to_a).sort! {|a,b| a.title <=> b.title} unless p[:q].blank?
  end
end