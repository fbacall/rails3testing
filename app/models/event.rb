class Event < ActiveRecord::Base
  attr_accessible :description, :title, :zone, :time, :date, :creator

  belongs_to :creator, :class_name => 'User'

  def date
    self.when.try(:to_date)
  end

  def date=(d)
    self.when ||= DateTime.new
    d = Date.parse(d)
    self.when = self.when.change(:day => d.day, :month => d.month, :year => d.year)
  end

  def time
    self.when.try(:to_time)
  end

  def time=(t)
    self.when ||= DateTime.new
    t = Time.parse(t)
    self.when = self.when.change(:hour => t.hour, :min => t.min)
  end

  def zone
    self.time_zone
  end

  # Offset stored date according to time zone
  def zone=(tz)
    self.when ||= DateTime.new
    hour = self.when.hour
    min = self.when.min
    self.when = self.when.in_time_zone(tz).change(:hour => hour, :min => min)
    self.time_zone = tz
  end

end
