class EventImporter
  attr_reader :user_credentials

  def self.import_events!(user_credentials)
    self.new(user_credentials).import_all_events
  end

  def initialize(user_credentials)
    @user_credentials = user_credentials
  end

  def import_all_events
    result = $client.execute(:api_method => $calendar.events.list,
                             :parameters => {'calendarId' => $calendar_id, 'timeMin' => DateTime.now.beginning_of_day, 'timeMax' => (DateTime.now + 4.months).end_of_day, 'maxResults' => 10, 'singleEvents' => true},
                             :authorization => user_credentials)
    import_events result.data.items
  end

  def create_event(event, recurs=false)
    address = Geocoder.search("#{event["location"]}")
    #logger.warn("Failed to find location for event: #{JSON(event.to_json)}") if address.blank? || address.first.blank?
    return nil if address.blank? || address.first.blank?

    latitude = address.first.latitude
    longitude = address.first.longitude

    Event.create!(client: event["summary"],
      external_id: event["id"],
      start_time: event["start"]["dateTime"],
      end_time: event["end"]["dateTime"],
      sequence: event["sequence"],
      latitude: latitude,
      longitude: longitude,
      recurs: recurs)
  end

  def import_recurring_events(event)
    puts "importing recurring events"
    result = $client.execute(:api_method => $calendar.events.instances,
                             :parameters => {'calendarId' => $calendar_id, 'eventId' => event["id"], 'maxResults' => 10},
                             :authorization => user_credentials)
    import_events result.data.items, true
  end

  def import_events(events, recurs=false)
    events.each do |event|
      unless event["recurrence"].blank?
        import_recurring_events(event)
      else
        create_event(event, recurs)
      end
    end
  end
end
