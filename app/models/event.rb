class Event
  include Mongoid::Document
  include EventCalendar
  scope :upcoming, lambda {where("start_at > ?", Time.zone.now).order("start_at ASC")}
  has_event_calendar
  field :name
  field :start_at, :type => DateTime
  field :end_at, :type => DateTime
  field :all_day, :type => Boolean
  field :description
  field :color
  
  def title
    name
  end
  def body
    description
  end
end