module EventsHelper

  def events_title(date)
    if date == Date.today
      "Today's Events"
    elsif date == (Date.today - 1.day)
      "Yesterday's Events"
    elsif date == (Date.today + 1.day)
      "Tomorrow's Events"
    else
      "Events on #{date.strftime()}"
    end
  end

end
