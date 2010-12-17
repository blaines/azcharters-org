class MarketplacePost
  include Mongoid::Document
  include Mongoid::Timestamps
  # attr_accessible :title, :zip, :price_in_cents, :body
  field :title
  field :zip, :type => Integer
  field :price_in_cents, :type => Integer
  field :body
  referenced_in :user
  
  def price
    self.price_in_cents.to_i/100.0
  end
  def price=(string)
    self.price_in_cents = string.gsub(/[^0-9\.]/,"").to_f.round(2)*100
  end
end
