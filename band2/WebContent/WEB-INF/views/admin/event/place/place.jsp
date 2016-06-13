<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<style type="text/css">
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
.controls {
  margin-top: 10px;
  border: 1px solid transparent;
  border-radius: 2px 0 0 2px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  height: 32px;
  outline: none;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
}

#pac-input {
  background-color: #fff;
  font-family: Roboto;
  font-size: 15px;
  font-weight: 300;
  margin-left: 12px;
  padding: 0 11px 0 13px;
  text-overflow: ellipsis;
  width: 300px;
}

#pac-input:focus {
  border-color: #4d90fe;
}

.pac-container {
  font-family: Roboto;
}

#type-selector {
  color: #fff;
  background-color: #4d90fe;
  padding: 5px 11px 0px 11px;
}

#type-selector label {
  font-family: Roboto;
  font-size: 13px;
  font-weight: 300;
}

</style>

<style>
      #target {
        width: 345px;
      }
</style>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script id="microloader" type="text/javascript" src=".sencha/app/microloader/development.js"></script>
<script type="text/javascript">

	var map;
	
	function initMap() {
	  map = new google.maps.Map(document.getElementById('map'), {
	    center: {lat: 37.555131, lng: 126.937401},
	    zoom: 8
	  });
	}
	

	  // Create the search box and link it to the UI element.
	  var input = document.getElementById('pac-input');
	  var searchBox = new google.maps.places.SearchBox(input);
	  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

	  // Bias the SearchBox results towards current map's viewport.
	  map.addListener('bounds_changed', function() {
	    searchBox.setBounds(map.getBounds());
	  });

	  var markers = [];
	  // Listen for the event fired when the user selects a prediction and retrieve
	  // more details for that place.
	  searchBox.addListener('places_changed', function() {
	    var places = searchBox.getPlaces();

	    if (places.length == 0) {
	      return;
	    }

	    // Clear out the old markers.
	    markers.forEach(function(marker) {
	      marker.setMap(null);
	    });
	    markers = [];

	    // For each place, get the icon, name and location.
	    var bounds = new google.maps.LatLngBounds();
	    places.forEach(function(place) {
	      var icon = {
	        url: place.icon,
	        size: new google.maps.Size(71, 71),
	        origin: new google.maps.Point(0, 0),
	        anchor: new google.maps.Point(17, 34),
	        scaledSize: new google.maps.Size(25, 25)
	      };

	      // Create a marker for each place.
	      markers.push(new google.maps.Marker({
	        map: map,
	        icon: icon,
	        title: place.name,
	        position: place.geometry.location
	      }));

	      if (place.geometry.viewport) {
	        // Only geocodes have viewport.
	        bounds.union(place.geometry.viewport);
	      } else {
	        bounds.extend(place.geometry.location);
	      }
	    });
	    map.fitBounds(bounds);
	  });

</script>



<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="bodyFrame">
	  <div class="x_panel">
	    <div class="x_title">
	            <h2>
	               <i class="fa fa-map-marker"></i> <small>추천 모임 장소</small>
	            </h2>
	            <ul class="nav navbar-right panel_toolbox">
	               <li class="dropdown"><a href="#" class="dropdown-toggle"
	                  data-toggle="dropdown" role="button" aria-expanded="false"><i
	                     class="fa fa-wrench"></i></a>
	                  <ul class="dropdown-menu" role="menu">
	                     <li><a href="#">Settings 1</a></li>
	                     <li><a href="#">Settings 2</a></li>
	                  </ul></li>
	               <li><a class="close-link"><i class="fa fa-file-excel-o"></i></a></li>
	               <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
	            </ul>
	            
	            
	            <div class="clearfix"></div>
	    </div>
	    <div class="x_content">
	     	<input id="pac-input" class="controls" type="text" placeholder="Search Box">
	    	<div id="map" style="height: 480px; width:640px;"></div>
	    	<script>
			// This example adds a search box to a map, using the Google Place Autocomplete
			// feature. People can enter geographical searches. The search box will return a
			// pick list containing a mix of places and predicted search terms.
			
			function initAutocomplete() {
			  var map = new google.maps.Map(document.getElementById('map'), {
			    center: {lat: 37.555131, lng: 126.937401},
			    zoom: 16,
			    mapTypeId: google.maps.MapTypeId.ROADMAP
			  });
			
			  // Create the search box and link it to the UI element.
			  var input = document.getElementById('pac-input');
			  var searchBox = new google.maps.places.SearchBox(input);
			  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
			
			  // Bias the SearchBox results towards current map's viewport.
			  map.addListener('bounds_changed', function() {
			    searchBox.setBounds(map.getBounds());
			  });
			
			  var markers = [];
			  // [START region_getplaces]
			  // Listen for the event fired when the user selects a prediction and retrieve
			  // more details for that place.
			  searchBox.addListener('places_changed', function() {
			    var places = searchBox.getPlaces();
			
			    if (places.length == 0) {
			      return;
			    }
			
			    // Clear out the old markers.
			    markers.forEach(function(marker) {
			      marker.setMap(null);
			    });
			    markers = [];
			
			    // For each place, get the icon, name and location.
			    var bounds = new google.maps.LatLngBounds();
			    places.forEach(function(place) {
			      var icon = {
			        url: place.icon,
			        size: new google.maps.Size(71, 71),
			        origin: new google.maps.Point(0, 0),
			        anchor: new google.maps.Point(17, 34),
			        scaledSize: new google.maps.Size(25, 25)
			      };
			
			      // Create a marker for each place.
			      markers.push(new google.maps.Marker({
			        map: map,
			        icon: icon,
			        title: place.name,
			        position: place.geometry.location
			      }));
			
			      if (place.geometry.viewport) {
			        // Only geocodes have viewport.
			        bounds.union(place.geometry.viewport);
			      } else {
			        bounds.extend(place.geometry.location);
			      }
			    });
			    map.fitBounds(bounds);
			  });
			  // [END region_getplaces]
			}
			
			
	    	</script>
	    	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCK3KYi7Rbf3EhUslNwTTrvTlfvfyrgOVA&libraries=places&callback=initAutocomplete"
			         async defer></script>
	    </div>
	
	  </div>
	</div>
</div>
