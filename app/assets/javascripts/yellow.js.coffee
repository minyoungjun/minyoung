# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



#   <script src="http://maps.google.com/maps?file=api&v=2&key=AIzaSyB4FlBliFBmgqVp7vWH1P3fqrnJycNHUhQ" type="text/javascript"></script>
#<!-- According to the Google Maps API Terms of Service you are required display a Google map when using the Google Maps API. see: http://code.google.com/apis/maps/terms.html -->
#<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=true"></script>    

#<script type="text/javascript">

    var my_lat, my_lon, geocoder, location1, location2, map, my_location;

#여기서부터는 내위치찾는거
function initialize() {

  geocoder = new GClientGeocoder();

  var mapOptions = {
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

# // Try HTML5 geolocation 여기에서 position.coords.latitude 이게 의심스러움ㅋㅋ
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {

        my_lat = position.coords.latitude;
       my_lon = position.coords.longitude;
      
        var pos = new google.maps.LatLng(position.coords.latitude,
                                       position.coords.longitude);

      var infowindow = new google.maps.InfoWindow({
        

        map: map,
        position: pos,
        content: '당신의 위치입니다.'
      });

      map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }
}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }

  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };

  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}

google.maps.event.addDomListener(window, 'load', initialize);




#이밑에꺼는 거리계산하는거

    function showLocation() {
        geocoder.getLocations(document.forms[0].address1.value, function (response) {
            if (!response || response.Status.code != 200)
            {
                alert("Sorry, we were unable to geocode the first address");
            }
            else
            {
                location1 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
             calculateDistance(); 
               // geocoder.getLocations(document.forms[0].address2.value, function (response) {
                   // if (!response || response.Status.code != 200)
                   // {
                     //   alert("Sorry, we were unable to geocode the second address");
                   // }
                   // else
                   // {
                    //    location2 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
    //                    calculateDistance();
                   // }
              //  });
                
            }
        });
    }
    
    function calculateDistance()
    {
        try
        {
            var glatlng1 = new GLatLng(location1.lat, location1.lon);
            var glatlng2 = new GLatLng(my_lat, my_lon);
            var miledistance = glatlng1.distanceFrom(glatlng2, 3959).toFixed(1);
            var kmdistance = (miledistance * 1.609344).toFixed(1);

            document.getElementById('results').innerHTML = '<strong> 실험. 위도와 경도: </strong>' + location1.lat + ', ' + location1.lon + '<br/><strong> 당신이 가고싶은 곳의 주소: </strong>' + location1.address + '<br />' + '<br/>' + '<br /><strong>당신이 있는 곳부터의 거리: </strong>' + kmdistance + ' (km)';
        }
        catch (error)
        {
            alert(error);
        }
    }

#   </script>
 

