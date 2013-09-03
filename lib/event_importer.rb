class EventImporter

  def self.import_events!
    result = $client.execute(:api_method => $calendar.events.list,
                             :parameters => {'calendarId' => $calendar_id},
                             :authorization => user_credentials)
    self.new.import_events result.data.items
  end

  def create_event(event, recurs=false)
    address = Geocoder.search("#{event["location"]}")
    logger.warn("Failed to find location for event: #{JSON(event.to_json)}") if address.blank? || address.first.blank?
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
    # result = $client.execute(api_method: $calendar.events.instances, ...)
    # import_events result.data.items, true
  end

  def import_events(events)
    events.each do |event|
      unless event["recurrence"].blank?
        import_recurring_events(event)
      else
        create_event(event)
      end
    end
  end
end