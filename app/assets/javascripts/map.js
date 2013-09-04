var Colors = {
  0: 'FF00FF',
  1: '00FF00',
  2: '0000FF',
  3: 'FFFF00',
  4: 'FF9900',
  5: 'FF0000',
  6: 'DDD'
};

var createMap = function(lat, lon) {

  var mapOptions = {
    center: new google.maps.LatLng(lat,lon),
    zoom: 13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  return new google.maps.Map($("#map")[0],mapOptions);
};

var createEventMarker = function(map, event) {
  console.log(event.start_time);
  var pinColor = Colors[(new Date(event.start_time)).getDay()];
  var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
        new google.maps.Size(21, 34),
        new google.maps.Point(0,0),
        new google.maps.Point(10, 34));
  var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
        new google.maps.Size(40, 37),
        new google.maps.Point(0, 0),
        new google.maps.Point(12, 35));

  var markerOptions = {
    position: new google.maps.LatLng(event.latitude, event.longitude),
    visible: true,
    clickable: true,
    icon: pinImage,
    shadow: pinShadow
  };

  var marker = new google.maps.Marker(markerOptions);
  marker.setMap(map);
  marker.setTitle(event.client);
  google.maps.event.addListener(marker,'click',function(){
    showEventInfo(event, marker);
    // window.location.href = '/jams/start';
  });
};

var showEventInfo = function(){

};