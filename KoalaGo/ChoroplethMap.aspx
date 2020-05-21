<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoroplethMap.aspx.cs" Inherits="KoalaGo.ChoroplethMap" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Choropleth Map</title>
    <link rel="stylesheet" href="leaflet/leaflet.css"/>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="leaflet/leaflet.js"></script>
    <script src="choroplethmap/suburbgeo_new.js"></script>
    <link rel="stylesheet" type="text/css" href="choroplethmap/style.css" />
</head>
<body>
    <main id="main">
    <div class="container">
        <div class="row" style="margin-top: 100px;margin-bottom: 100px">
            <div id="map" class="col-lg-12" style="margin-bottom: 50px; margin-top: 50px"></div>
        </div>
    </div>

    <script>
        var mapboxAccessToken = 'pk.eyJ1Ijoid2F5bmVzaGVuZ3l1YW4iLCJhIjoiY2thNm56cm9jMGFzMzJyb3p0c2sxaGhkdiJ9.SWUZj_CQm6jsemueIW_zzw';
        var map = L.map('map').setView([-28, 149], 6);

        L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=' + mapboxAccessToken, {
            id: 'mapbox/light-v10',
            attribution:'',
            tileSize: 512,
            zoomOffset: -1
        }).addTo(map);

        function getColor(d) {
            return d >= 300 ? '#800026' :
                d >= 200  ? '#bd0026' :
                    d >= 100  ? '#E31A1C' :
                        d >= 50  ? '#FC4E2A' :
                            d >= 30   ? '#FD8D3C' :
                                d >= 10   ? '#FEB24C' :
                                    d >= 1   ? '#FED976' :
                                        'rgba(255,237,160,0)';
        }
        function style(feature) {
            return {
                fillColor: getColor(feature.properties.count),
                weight: 2,
                opacity: 1,
                color: 'white',
                dashArray: '3',
                fillOpacity: 0.7
            };
        }

        geojson = L.geoJson(suburbGeo, {
            style: style,
            onEachFeature: onEachFeature
        }).addTo(map);


        function highlightFeature(e) {
            var layer = e.target;
            layer.setStyle({
                weight: 5,
                color: '#666',
                dashArray: '',
                fillOpacity: 0.7
            });
            if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
                layer.bringToFront();
            }
            info.update(layer.feature.properties);
        }

        function resetHighlight(e) {
            geojson.resetStyle(e.target);
            info.update();
        }

        function zoomToFeature(e) {
            map.fitBounds(e.target.getBounds());
        }

        function onEachFeature(feature, layer) {
            layer.on({
                mouseover: highlightFeature,
                mouseout: resetHighlight,
                //click: zoomToFeature
            });
        }

        var info = L.control();

        info.onAdd = function (map) {
            this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
            this.update();
            return this._div;
        };

        // method that we will use to update the control based on feature properties passed
        info.update = function (props) {
            this._div.innerHTML = '<h4>Koala population</h4>' +  (props ?
                '<b>' + props.suburb + '</b><br />' + props.count  + ' koala records</b><br />Most probable month: ' + props.month + '<sup></sup>'
                : 'Hover over Hotspots');
        };

        info.addTo(map);

        var legend = L.control({position: 'bottomright'});

        legend.onAdd = function (map) {

            var div = L.DomUtil.create('div', 'info legend'),
                grades = [0, 1, 10, 30, 50, 100, 200, 300],
                labels = [];

            // loop through our density intervals and generate a label with a colored square for each interval
            for (var i = 0; i < grades.length; i++) {
                div.innerHTML +=
                    '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
                    grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
            }

            return div;
        };

        legend.addTo(map);

    </script>

</main>
</body>
</html>
