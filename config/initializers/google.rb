$client = Google::APIClient.new
$client.authorization.client_id = ENV['GOOGLE_API_CLIENT_ID']
$client.authorization.client_secret = ENV['GOOGLE_API_CLIENT_SECRET']
$client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

$calendar = $client.discovered_api('calendar', 'v3')
$calendar_id = ENV["GOOGLE_API_CALENDAR_ID"]