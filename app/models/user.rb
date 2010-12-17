class User
  Roles = [:admin, :member]
  include Mongoid::Document
  referenced_in :account
  referenced_in :contact
  references_many :marketplace_posts
  references_many :news_posts
  field :role, :type => Symbol
  field :name, :type => String
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Tries to define a name if none exists
  def name
    if self[:name].blank?
      unless self.contact.nil?
        update_attributes(:name => self.contact.name)
      end
    end
    self[:name]
  end
  
  def admin?
    self.role == :admin
  end
  def member?
    self.role == :member
  end
end