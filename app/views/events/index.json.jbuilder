json.array!(@events) do |event|
  json.extract! event, :external_id, :client, :sequence, :latitude, :longitude, :recurs
  json.start_time event.start_time.localtime.strftime('%I:%M %p') if event.start_time
  json.end_time event.end_time.localtime.strftime('%I:%M %p') if event.end_time
  json.day_of_week event.start_time.localtime.strftime('%a') if event.start_time
  json.url event_url(event, format: :json)
end
