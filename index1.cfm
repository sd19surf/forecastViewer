<!DOCTYPE html>
<html>
<cfinclude template="./includes/header.cfm" />

<body>


<script>

var mapLat = 34;
var mapLon = 50;
var sliderControl = null;
var testlayer;
var world;
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
    
 var states = L.geoJson(blocks, {
     onEachFeature: onEachFeature,
     style: function(feature){
         switch(feature.properties.party){
             case 'Democrat': return {color: "#0000ff"};
             case 'Republican': return {color: "#ff0000"};
         }
      }
 });

//maps section and backgrounds

//var map = L.map('mapid').setView([mapLat, mapLon],3);
    
var map = L.map('mapid',{zoomControl:true}).setView([mapLat, mapLon], 3);

var openStreet = L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 10,
    id: 'mapbox.streets',
    attribution: "OpenStreet Maps"
});
    
    
var stringWorld = L.geoJson(worldMap, {
        attribution: "Natural Earth Countries"
        }).addTo(map);
    
var stringCoastline = L.geoJson(coastline, {
        attribution: "Natural Earth Coastline"
        });


   // var intersection = turf.intersect(stringWorld, testlayer);
    
   // console.log(intersection);

    
// Scales and other features
    
L.control.scale().addTo(map);
    
//map.addControl(L.control.fractionalZoom({position: 'topright', zoomIncrement:.5}));
    
var baseLayers = {
    
    "OpenStreetMap": openStreet,
    "String World": stringWorld,
    "String Coastline": stringCoastline
};
var overlays = {
    "States": states
};
    
L.control.layers(baseLayers, overlays).addTo(map);
    
    
    
// additional functions 
    
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
        /* add turf comparsion        
       // var points = turf.getCoord(returnedJSON);        
       // var searchWithin = turf.getCoords(testLayer); 
       // console.log (JSON.stringify(returnedJSON));
        console.log (JSON.stringify(testlayer));
        var pointWithin = turf.pointsWithinPolygon(returnedJSON, testlayer);        
        console.log(pointWithin);
        */
    for (var i=0; i < returnedJSON.length; i++){
        addNewPoint(returnedJSON[i].LAT,returnedJSON[i].LON);
        console.log(returnedJSON[i].STATION_NAME);
        out += "<tr><td>"+ returnedJSON[i].STATION_NAME+"</td><td>"+returnedJSON[i].LAT+"</td><td>"+ returnedJSON[i].LON+"</td></tr>";
     }
        document.getElementById('threatTable').innerHTML=out;
     }
    }
   
  xhttp.open("POST", "viewer.cfc?method=getCountryICAOS&countryCode=IZ", true);
  //xhttp.open("POST", "viewer.cfc?method=getStations", true);
  xhttp.send();

     
} 

</script>

</body>
</html>
