class Page
  include Mongoid::Document
  include Mongoid::Acts::Tree
  field :title
  field :slug
  field :body
  field :image
  references_many :pages
  referenced_in :page
  
  index :slug, :unique => true
  
  acts_as_tree :order => "title"
  
  before_create :generate_slug
    
  def to_param
    slug
  end
  
  protected
  
  def generate_slug
    self.slug = title.gsub(/\s/,"-").gsub(/[-]+/,"-").gsub(/[^a-z\s\-]/i,"").downcase+"~"+Tiny::tiny(self.class.count)
  end
    
end