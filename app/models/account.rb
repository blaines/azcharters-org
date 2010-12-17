class Account
  include Mongoid::Document
  #  current member
  #  balance
  #  name
  #  phone
  #  fax
  #  address
  #  many contacts
  #  salesforce_id
  #  last_updated
  field :current_member__c
  field :pds__current_balance__c
  field :name
  field :phone
  field :fax
  field :pds__qb_billing_address__c
  field :primary_email__c
  field :current_member__c, :type => Boolean
  field :salesforce_id
  field :salesforce_updated_at
  references_many :contacts, :foreign_key => :db_account_id, :dependent => :destroy
  references_many :users, :dependent => :destroy
  
end