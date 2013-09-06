var Colors = {
  'Sunday': 'FF00FF',
  'Monday': '00FF00',
  'Tuesday': '0000FF',
  'Wednesday': 'FFFF00',
  'Thursday': 'FF9900',
  'Friday': 'FF0000',
  'Saturday': 'DDD'
};

var map;
var overlappingMarkerSpiderfier;
var markerInfoWindow;
var allLocations = {};

var createLegend = function() {
  var legendContainer = $("#map-legend");
  var list = $('<ul></ul>');
  legendContainer.append(list);
  for (var dayOfWeek in Colors) {
    list.append(legendItem(dayOfWeek));
  }
};

var legendItem = function(dayOfWeek) {
  var pinImageSrc = pinImageSource(Colors[dayOfWeek]);
  return $('<li><img src="' +
    pinImageSrc +
    '" altText="' +
    dayOfWeek +
    '" /><br /><span class="day-of-week">' +
    dayOfWeek +
    '</span></li>');
};

var createMap = function(lat, lon) {
  var mapOptions = {
    center: new google.maps.LatLng(42.3488218, -83.0593771),
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map($("#map")[0],mapOptions);
  overlappingMarkerSpiderfier = new OverlappingMarkerSpiderfier(map);
  markerInfoWindow  = new google.maps.InfoWindow();
  overlappingMarkerSpiderfier.addListener('hover', function(marker, event) {
    markerInfoWindow.setContent(marker.desc);
    markerInfoWindow.open(map, marker);
  });
  overlappingMarkerSpiderfier.addListener('spiderfy', function(markers) {
    markerInfoWindow.close();
  });
};

var pinImageSource = function(pinColor) {
  return "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor;
}

var createEventMarker = function(event) {
  var locationKey = event.latitude + "," + event.longitude;
  if (!allLocations.hasOwnProperty(locationKey)) {
    allLocations[locationKey] = 0;
  } else {
    allLocations[locationKey] = allLocations[locationKey] + 0.001;
  }

  var pinColor = Colors[event.day_of_week];
  var markerOptions = {
    position: new google.maps.LatLng(event.latitude + allLocations[locationKey], event.longitude),
    visible: true,
    clickable: true,
    // draggable: true,
    icon: {
      url: pinImageSource(pinColor),
      size: new google.maps.Size(21, 34),
      anchor: google.maps.Point(0, 0)
    },
    map: map,
    title: event.client + "\nFrom " + event.start_time + " to " + event.end_time
  };

  var marker = new google.maps.Marker(markerOptions);
  marker.desc = event.client;
  overlappingMarkerSpiderfier.addMarker(marker);
  google.maps.event.addListener(marker,'click',function(){
    showEventInfo(event, marker);
  });
};

var showEventInfo = function(){

};
