<!DOCTYPE html>
<html>
<cfinclude template="./includes/header.cfm" />
<script src="blocks.json" type="text/javascript"></script>

<body>


<script>

var mapLat = 34;
var mapLon = 50;
var sliderControl = null;

//Leaflet map stuff




</script>

<div class="row">
<div class="col-sm-4" id="threat">
<table id="threatTable">

</table>
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
    




var map = L.map('mapid').setView([mapLat, mapLon], 7);

var openStreet = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 10,
    id: 'mapbox.streets'
}).addTo(map);
    
 var states = L.geoJson(blocks, {
     onEachFeature: onEachFeature,
     style: function(feature){
         switch(feature.properties.party){
             case 'Democrat': return {color: "#0000ff"};
             case 'Republican': return {color: "#ff0000"};
         }
      }
 });
    
L.control.scale().addTo(map);
    
var baseLayers = {
    "OpenStreetMap": openStreet
};
var overlays = {
    "States": states
};
L.control.layers(baseLayers, overlays).addTo(map);
    
window.onload=function() {
    getICAOs();
}

    

function addNewPoint(mapLat, mapLon){
	L.marker([mapLat, mapLon]).addTo(map);
}

function onEachFeature(feature, layer) {
    // does this feature have a property named popupContent?
    if (feature.properties && feature.properties.popupInformation) {
        layer.bindPopup(feature.properties.popupInformation);
    }
}
    
function getICAOs() {
  var out = "<tr><th>Station</th><th>Lat</th><th>Lon</th></tr>";
  var xhttp; 
  var returnedJSON;

  xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
        var returnedJSON = JSON.parse(this.responseText);
    for (var i=0; i < returnedJSON.length; i++){
        addNewPoint(returnedJSON[i].LAT,returnedJSON[i].LON);
        console.log(returnedJSON[i].STATION_NAME);
        out += "<tr><td>"+ returnedJSON[i].STATION_NAME+"</td><td>"+returnedJSON[i].LAT+"</td><td>"+ returnedJSON[i].LON+"</td></tr>";
     }
        document.getElementById('threatTable').innerHTML=out;
     }
    }
    
  xhttp.open("POST", "viewer.cfc?method=getCountryICAOS&countryCode=IZ", true);
  xhttp.send();

    
} 

</script>

</body>
</html>
