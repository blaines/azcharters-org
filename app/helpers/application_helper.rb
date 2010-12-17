# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def navigation(options={})
    nav = content_tag :ul, :class => "navigation" do
      @navigation_tabs.to_s
    end
    @navigation_tabs = [] unless options[:save_tabs]
    nav
  end
  def tab_to(link,sym,options={})
    @navigation_tabs ||= []
    options[:class] = "current" if sym==@current_tab.to_sym
    @navigation_tabs << content_tag(:li, link, options)
  end
  
  def tree_ul(acts_as_tree_set, init=true, &block)
    if acts_as_tree_set.size > 0
      ret = '<ul>'
      acts_as_tree_set.collect do |item|
        next if item.parent_id && init
        ret += '<li>'
        ret += yield item
        ret += tree_ul(item.children, false, &block) if item.children.size > 0
        ret += '</li>'
      end
      ret += '</ul>'
    end
  end
  
  def admin?
    false
    current_user.admin? if user_signed_in?
  end
  
  def arr_to_tags(arr)
    a = arr.split(",").map {|c| "<span class='tag'>#{c}</span>"}
    a.join
  end
end
