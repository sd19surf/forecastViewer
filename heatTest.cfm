
<html>
<head>
  <meta charset=utf-8 />
  <title>Points as a heatmap</title>
  <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />

    <!-- Load Leaflet from CDN -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.2.0/dist/leaflet.css"
    integrity="sha512-M2wvCLH6DSRazYeZRIm1JnYyh22purTM+FDB5CsyxtQJYeKq83arPe5wgbNmcFXGqiSH2XR8dT/fJISVA1r/zQ=="
    crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.2.0/dist/leaflet.js"
    integrity="sha512-lInM/apFSqyy1o6s89K4iQUKg6ppXEgsVxT35HbzUupEVRh2Eu9Wdl4tHj7dZO0s1uvplcYGmt3498TtHq+log=="
    crossorigin=""></script>


    <!-- Load Esri Leaflet from CDN -->
    <script src="https://unpkg.com/esri-leaflet@2.1.1/dist/esri-leaflet.js"
    integrity="sha512-ECQqaYZke9cSdqlFG08zSkudgrdF6I1d8ViSa7I3VIszJyVqw4ng1G8sehEXlumdMnFYfzY0tMgdQa4WCs9IUw=="
    crossorigin=""></script>


  <style>
    body { margin:0; padding:0; }
    #map { position: absolute; top:0; bottom:0; right:0; left:0; }
  </style>
</head>
<body>

<!-- Include Leaflet.heat via rawgit.com
in production you'd be better off hosting this library yourself -->

<script src="https://rawgit.com/Leaflet/Leaflet.heat/gh-pages/dist/leaflet-heat.js"></script>

<!-- Load Heatmap Feature Layer from CDN -->
<script src="https://unpkg.com/esri-leaflet-heatmap@2.0.0"></script>

<div id="map"></div>

<script>
  var map = L.map('map').setView([ 40.706, -73.926], 14);

  L.esri.basemapLayer('Gray').addTo(map);

  // new constructor syntax at 2.0.0
  L.esri.Heat.featureLayer({
    url: 'https://idpgis.ncep.noaa.gov/arcgis/rest/services/NWS_Forecasts_Guidance_Warnings/watch_warn_adv/MapServer/0',
    radius: 12
  }).addTo(map);
</script>

</body>
</html>