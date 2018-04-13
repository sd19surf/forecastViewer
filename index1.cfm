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
<!---
<button id='snap' class='ui-button'>Take a snapshot</button>

<div id='snapshot'>test</div>
--->
    <div id="sidebar">
        <h1>leaflet-sidebar</h1>

        <p>A responsive sidebar plugin for for <a href="http://leafletjs.com/">Leaflet</a>, a JS library for interactive maps.</p>

        <p><b>Click on the marker to show the sidebar again when you've closed it.</b></p>

        <p>Other examples:</p>

        <ul>
            <li><a href="listing-markers.html">listing-markers example</a></li>
            <li><a href="two-sidebars.html">two-sidebars example</a></li>
        </ul>

        <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

        <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

        <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>

        <p class="lorem">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
    </div>
<div class="col-sm-8" id="mapid"></div>
</div>

<script>
    



//Fetch some data from a GeoJSON file


$.getJSON("28map.geojson", function(json) {


	var testlayer = L.geoJson(json,{
	onEachFeature: onEachFeature,
	style: function(feature){
	    switch (feature.properties.threat){
		case 'High Winds': return {color: "#ff0000"};
		case 'Duststorm' : return {color: "#804000"};
		case 'Tornado' : return {color: "#0000ff"};
	    }
	}
	});
    

	var sliderControl = L.control.sliderControl({

	    position: "bottomleft",

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

//playing with heatmap
var heat = L.heatLayer([], {maxZoom: 18}).addTo(map);

var draw = true;


        var sidebar = L.control.sidebar('sidebar', {
            closeButton: true,
            position: 'left'
        });
        map.addControl(sidebar);

        setTimeout(function () {
            sidebar.show();
        }, 500);

        var marker = L.marker([51.2, 7]).addTo(map).on('click', function () {
            sidebar.toggle();
        });

        map.on('click', function () {
            sidebar.hide();
        })

        sidebar.on('show', function () {
            console.log('Sidebar will be visible.');
        });

        sidebar.on('shown', function () {
            console.log('Sidebar is visible.');
        });

        sidebar.on('hide', function () {
            console.log('Sidebar will be hidden.');
        });

        sidebar.on('hidden', function () {
            console.log('Sidebar is hidden.');
        });

        L.DomEvent.on(sidebar.getCloseButton(), 'click', function () {
            console.log('Close button clicked.');
        });

// add points on mouse move (except when interacting with the map)

/*map.on({
    movestart: function () { draw = false; },
    moveend:   function () { draw = true; },
    mousemove: function (e) {
        if (draw) {
            heat.addLatLng(e.latlng);

        }
    }
})
*/
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
    var Latlng = [mapLat,mapLon];
	L.circleMarker(Latlng, {radius:1, color:'darkgreen'}).addTo(map);
}

function onEachFeature(feature, layer) {
    // does this feature have a property named popupContent?
    if (feature.properties && feature.properties.threat_detail && feature.properties.time && feature.properties.threat) {
        layer.bindPopup("Threat: "+ feature.properties.threat +"<br>" + "Time :" + feature.properties.time + "<br>" + "Detail: " + feature.properties.threat_detail);
    }
}
    
function getICAOs() {
  var out = "<h2>Threat Table</h2><br /><tr><th>Station</th><th>Lat</th><th>Lon</th></tr>";
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
        
        
var cluster = [];
var pointCollection = [];
var features=[];
var point1;

$.getJSON("28map.geojson", function(data){

    features = data.features;
    
for (var j = 0; j < returnedJSON.length; j++) {
    
   console.log("Number of points:"+j); 
    // make a feature collection of the points returned
    pointCollection.push(turf.point([returnedJSON[j].LAT,returnedJSON[j].LON], {"Station_Name": returnedJSON[j].STATION_NAME}));
}
    //addNewPoint(returnedJSON[j].LAT,returnedJSON[j].LON);
 //assign the array to the featureCollection
var icaoCollection = turf.featureCollection(pointCollection);
    
console.log(JSON.stringify(icaoCollection.features[0]));

// collect all the stations in the polyfeatures

var threatBases = turf.collect(data,icaoCollection,"Station_Name","Station_Name");

var taggedBases = turf.tag(data,icaoCollection,'threat','threat');
    
    
var pointsWithin = turf.pointsWithinPolygon(icaoCollection.features[0],data);

console.log(JSON.stringify(pointsWithin));

console.log(taggedBases.features[1]);   


   // createTable(cluster);  //Create table of attributes
}

);
    for (var i=0; i < cluster.length; i++){
        addNewPoint(cluster[i].LAT,cluster[i].LON);
       // heat.addLatLng([returnedJSON[i].LAT,returnedJSON[i].LON]);
        //console.log(returnedJSON[i].STATION_NAME);
        out += "<tr><td>"+ cluster[i].STATION_NAME+"</td><td>"+cluster[i].LAT+"</td><td>"+ cluster[i].LON+"</td></tr>";
     }
        document.getElementById('threatTable').innerHTML=out;
     }
    }
   
  xhttp.open("POST", "viewer.cfc?method=getCountryICAOS&countryCode=QA", true);
  //xhttp.open("POST", "viewer.cfc?method=getStations", true);
  xhttp.send();

     
} 
    
   var snapshot = document.getElementById('snapshot'); 
    
    document.getElementById('snap').addEventListener('click', function() {
        leafletImage(map, doImage);
        
});



function doImage(err, canvas) {
    var img = document.createElement('img');
    var dimensions = map.getSize();
    img.width = dimensions.x;
    img.height = dimensions.y;
    img.src = canvas.toDataURL();
    snapshot.innerHTML = '';
    snapshot.appendChild(img);

}
    
function customICAOMarkers(json,latlng) {
    //var attrib = json.properties;
    return L.circleMarker(Latlng, {radius:10, color:'darkgreen'}).bindTooltip(attrib.icao);
}

</script>

</body>
</html>
