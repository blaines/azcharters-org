class NewsPost
  include Mongoid::Document
  include Mongoid::Timestamps
  # attr_accessible :title, :body, :keywords
  field :title
  field :slug
  field :body
  field :categories, :type => Array
  referenced_in :user
  
  index :slug, :unique => true
  
  before_create :generate_slug
  
  # Effectively news_post_tags
  def self.tags
    @@tags ||= self.collection.map_reduce("function() {if (!this.categories) {return};for (index in this.categories) {emit(this.categories[index], 1)}}","function(previous, current) {var count = 0;for (index in current) {count += current[index]}; return count;}", :out => "news_post_tags", :sort => [['value', :desc]]).find.to_a.map {|e| {e["_id"].intern => e["value"]}}
  end
  
  def to_param
    slug
  end
  
  def categories=(string)
    write_attribute(:categories,string.split(/\s*,\s*/))
  end

  def categories
    c = read_attribute(:categories)
    c.join(",") unless c.blank?
  end
  
  protected
  
  def generate_slug
    self.slug = title.gsub(/\s/,"-").gsub(/[-]+/,"-").gsub(/[^a-z\s\-]/i,"").downcase+"~"+Tiny::tiny(self.class.count)
  end
  
end
