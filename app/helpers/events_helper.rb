module EventsHelper

  def events_title(date, period)
    period ||= 'day'

    if period == 'day'
      if date == Date.today
        "Today's Events"
      elsif date == (Date.today - 1.day)
        "Yesterday's Events"
      elsif date == (Date.today + 1.day)
        "Tomorrow's Events"
      else
        "Events on #{date.strftime()}"
      end
    elsif period == 'month'
      if date.month == Date.today.month
        "This Month's Events"
      else
        "Events in #{date.strftime('%B %Y')}"
      end
    end
  end

end
