<!DOCTYPE html>
<html>
<cfinclude template="./includes/header.cfm">

<body>


<script>

var mapLat = 34;
var mapLon = 50;
var sliderControl = null;

//Leaflet map stuff




</script>

<div class="row">
<div class="col-sm-4" id="threat">
<table name="threatTable">
     <tr>
	<th>Threat</th>
	<th>Information</th>
	<th>Valid Time</th>
    </tr>
    <tr>
	<td></td>
	<td></td>
	<td></td>
    </tr>

</div>
<div class="col-sm-8" id="mapid"></div>
</div>

<script>

//Fetch some data from a GeoJSON file


$.getJSON("points1.json", function(json) {


	var testlayer = L.geoJson(json,{
	onEachFeature: onEachFeature,
	style: function(feature){
	    switch (feature.properties.threat){
		case 'High Winds': return {color: "#ff0000"};
		case 'Duststorm' : return {color: "#804000"};
	    }
	}
	});


	var sliderControl = L.control.sliderControl({

	    position: "bottomright",

	    layer: testlayer,

	    follow: 1

	});



//Make sure to add the slider to the map ;-)

	map.addControl(sliderControl);

//An initialize the slider

	sliderControl.startSlider();

	});



var map = L.map('mapid').setView([mapLat, mapLon], 13);

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 5,
    id: 'mapbox.streets'
}).addTo(map);

function addNewPoint(){
	L.marker([mapLat, mapLon]).addTo(mapid);
}

function onEachFeature(feature, layer) {
    // does this feature have a property named popupContent?
    if (feature.properties && feature.properties.popupInformation) {
        layer.bindPopup(feature.properties.popupInformation);
    }
}

</script>

</body>
</html>
