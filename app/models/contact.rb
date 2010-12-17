class Contact
  include Mongoid::Document
  field :last_name
  field :first_name
  field :mailing_street
  field :mailing_city
  field :mailing_state
  field :mailing_postal_code
  field :phone
  field :fax
  field :email
  field :title
  field :account_id
  field :salesforce_id
  field :salesforce_updated_at
  referenced_in :account, :foreign_key => :db_account_id
  references_one :user
  
  def name
    "#{first_name} #{last_name}"
  end
  
end