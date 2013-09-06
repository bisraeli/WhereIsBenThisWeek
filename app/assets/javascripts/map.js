var Colors = {
  0: 'FF00FF',
  1: '00FF00',
  2: '0000FF',
  3: 'FFFF00',
  4: 'FF9900',
  5: 'FF0000',
  6: 'DDD'
};

var DaysOfWeek = {
  0: 'Sunday',
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday'
};

var map;
var oms;
var iw;
var createLegend = function() {
  var legendContainer = $("#map-legend");
  var list = $('<ul></ul>');
  legendContainer.append(list);
  for (var i in Colors) {
    list.append(legendItem(i));
  }
};

var legendItem = function(index) {
  var pinImageSrc = pinImageSource(Colors[index]);
  var dayOfWeek = DaysOfWeek[index];
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
    center: new google.maps.LatLng(40.754084,-73.966448),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map($("#map")[0],mapOptions);
  oms = new OverlappingMarkerSpiderfier(map);
  iw  = new google.maps.InfoWindow();
  oms.addListener('hover', function(marker, event) {
    iw.setContent(marker.desc);
    iw.open(map, marker);
  });
  oms.addListener('spiderfy', function(markers) {
    iw.close();
  });
};

var pinImageSource = function(pinColor) {
  return "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor;
}

var createEventMarker = function(event) {
  console.log(event.start_time);
  var pinColor = Colors[(new Date(event.start_time)).getDay()];
  var pinImage = new google.maps.MarkerImage(pinImageSource(pinColor),
        new google.maps.Size(21, 34),
        new google.maps.Point(0, 0),
        new google.maps.Point(10, 34));
  var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(5, 5),
        new google.maps.Point(12, 35));

  var markerOptions = {
    position: new google.maps.LatLng(event.latitude, event.longitude),
    visible: true,
    clickable: true,
    //draggable: true,
    icon: pinImage,
    // shadow: pinShadow,
    map: map,
    title: event.client//event.start_time + "-" + event.end_time
  };

  var marker = new google.maps.Marker(markerOptions);
  marker.desc = event.client;
  oms.addMarker(marker);
  google.maps.event.addListener(marker,'click',function(){
    showEventInfo(event, marker);
    // window.location.href = '/jams/start';
  });
};

var showEventInfo = function(){

};