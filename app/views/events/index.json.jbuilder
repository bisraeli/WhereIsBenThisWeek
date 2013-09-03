json.array!(@events) do |event|
  json.extract! event, :external_id, :client, :start_time, :end_time, :sequence, :latitude, :longitude, :recurs
  json.url event_url(event, format: :json)
end
