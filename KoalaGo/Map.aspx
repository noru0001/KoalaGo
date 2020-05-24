<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="KoalaGo.Map" %>

<html>
<head>
    <meta charset="utf-8" />
    <title>Driving directions</title>
    <!-- Vendor JS Files -->
    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="assets/vendor/venobox/venobox.min.js"></script>
    <script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
    <script src="assets/vendor/counterup/counterup.min.js"></script>
    <script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/aos/aos.js"></script>

    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
    <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">

    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/leaflet-ruler.css" rel="stylesheet" />

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">

    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.mapbox.com/mapbox.js/v3.3.1/mapbox.js'></script>
    <link href='https://api.mapbox.com/mapbox.js/v3.3.1/mapbox.css' rel='stylesheet' />

    <script src="https://npmcdn.com/leaflet-geometryutil"></script>
    <script src="Scripts/Control.Geocoder.js"></script>

    <script src="Scripts/leaflet-ruler.js"></script>
    <script src="https://unpkg.com/esri-leaflet@2.3.3/dist/esri-leaflet.js"></script>

    <!-- Load Esri Leaflet Geocoder from CDN -->
    <link rel="stylesheet" href="https://unpkg.com/esri-leaflet-geocoder@2.3.2/dist/esri-leaflet-geocoder.css">
    <script src="https://unpkg.com/esri-leaflet-geocoder@2.3.2/dist/esri-leaflet-geocoder.js"></script>

    <!-- Leaflet.MarkerCluster -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.4/leaflet.markercluster.js'></script>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.4/MarkerCluster.css' rel='stylesheet' />
    <link href='https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.4/MarkerCluster.Default.css' rel='stylesheet' />

    <!-- test data -->
    <script src="https://www.mapbox.com/mapbox.js/assets/data/realworld.388.js"></script>

    <script src="lib/leaflet-messagebox.js"></script>
    <link href="css/leaflet-messagebox.css" rel="stylesheet" />
    <script src="lib/leaflet.smoothmarkerbouncing.js"></script>

    <script src="choroplethmap/suburbgeo_new.js"></script>
    <link rel="stylesheet" type="text/css" href="choroplethmap/style.css" />
    <script src="lib/suburbgeo_new.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        .myalign {
            text-align: left;
        }

        .tooltip-inner {
            width: 450px;
            background-color: #FFE97A;
            color: #244517;
            font-size: small;
            font-weight: bold;
        }

        #map {
            height: 100%;
        }
    </style>

    <script>
        //defining variables
        var geojson;
        var info;
        var clusters;
        var layerGroups;
        var circlelayer;
        var count = 0;
        var firelayer;
        var orglayer;
        var sakoala;
        var searchlayer;
        var popup;
        var directionsLayer;
        var chroplthlayer;
        var pastFires;
        var legend;

        var directionsInputControl;
        var mylat = [];
        var mylon = [];
        var mydis = [];

        $(document).ready(function () {
            //Set maximum value for past fire date field
            setMaxFIreDate();
            function setMaxFIreDate() {
                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1; //January is 0!
                var yyyy = today.getFullYear();
                if (dd < 10) {
                    dd = '0' + dd
                }
                if (mm < 10) {
                    mm = '0' + mm
                }

                today = yyyy + '-' + mm + '-' + dd;
                document.getElementById("txtdate").setAttribute("max", today);
            }

            //set all the tool tips
            $('[data-toggle="tooltip"]').tooltip();

            $("#div_chrolo").hide();
            //remove search when loading map
            removeSearch();
            $("#distanceval").hide();
            $("#inputs").hide();
            $("#myPopup").hide();
            $("#directions").hide();

            if (searchlayer != null)
                map.removeLayer(searchlayer);

            $("#inputs").click(function () {

                map.closePopup();
            });
            //loading past fires
            $("#firebtn").click(function () {

                if (pastFires != null) {
                    map.removeLayer(pastFires);
                }
                if ($("#txtdate").val() == '') {
                    alert("Please select past fire date!");
                } else {

                    displayPastFireInformation();

                }

            });
            //showing Navigation control and hiding other laters
            $("#GeoFunction1").click(function () {

                $("#distanceval").hide();
                $("#inputs").show();
                removeSearch();
                map.closePopup();
                circlelayer = L.layerGroup()
                map.addLayer(circlelayer);

            });
            //showing search function on the map
            $("#GeoFunction2").click(function () {

                if (directionsLayer != null) {
                    map.removeLayer(directionsLayer);
                }
                directionsLayer = L.mapbox.directions.layer(directions);

                directionsLayer.addTo(map);

                $("#distanceval").show();
                $("#inputs").hide();

                addSearch();
                map.closePopup();

            });
            //clear all in the map
            $("#GeoFunction3").click(function () {

                location.reload();

            });

            $('#mySelect').change(function () {
                var value = $(this).val();
            });
            //show individual koala sighting
            $("#rALLState").click(function () {
                if (geojson != null)
                    map.removeLayer(geojson);
                removeInfo();
                removelegend();

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                FilteredMapByState();
                $("#div_chrolo").show();
            });
            //show clustered sigting

            $("#allData").click(function () {
                if (geojson != null)
                    map.removeLayer(geojson);
                removeInfo();
                removelegend();

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                displayMapWithLocationCount();
                $("#div_chrolo").hide();

            });
            //Locading Choropleth map
            $("#cmbchoro").click(function () {
                if (geojson != null)
                    map.removeLayer(geojson);
                removeInfo();
                removelegend();

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                loadsecondMap();

            });
            //load QA and NSW fires
            setQAfires();
            setNSWfires();

            //get current yeat and month
            function getCurrentYearMonth() {

                var today = new Date();
                var month = (today.getMonth() + 1);
                if (month < 10) month = '0' + month;

                var yearMonth = today.getFullYear() + '' + month;
                return yearMonth;

            }

            function getYearMonthGivenDate(val) {

                var res = val.substring(0, 4) + val.substring(5, 7);
                return res;

            }
            //check the koala loacation is a recently seen location
            function checkIsRecentlySeenLocation(dateseen) {
                var currmonth = getCurrentYearMonth();
                var ds = getYearMonthGivenDate(dateseen);
                var newval = currmonth - 1;
                if (newval <= ds) {
                    return 1;
                }
                else {
                    return 0;
                }

            }
            //local insividual koala sighting
            function FilteredMapByState() {
                if (clusters != null)

                    map.removeLayer(clusters);

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                $.ajax({
                    type: "POST",
                    url: "Map.aspx/getKoalaInfo",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var json = JSON.parse(response.d);

                        var someFeatures = new String("");
                        var count = 0;
                        var iconRecentlySeen = L.icon({
                            iconSize: [30, 30],
                            iconUrl: 'Images/recentlySeen.png'

                        });
                        //defining image for last seen koalas
                        var koalaLoc1 = L.icon({
                            iconSize: [40, 40],
                            iconUrl: 'Images/koalaLoc.png'

                        });
                        //creating a new layer
                        layerGroups = L.layerGroup()
                        var v = 0;
                        var isAll = 0;

                        if (($("#rALLState").is(":checked")) == true) {

                            isAll = 1;
                        }

                        for (var i = 0; i < json.length; i++) {
                            var obj = json[i];
                            // Adding marker to the map
                            var lat = parseFloat(obj['lat']);
                            var lon = parseFloat(obj['lon']);

                            if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                                marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                            } else {

                                marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                            }
                            //add descriptions to the marker
                            marker.bindPopup('<div>' + '<b>Last seen on:</b>' + ' ' + obj['datefound'] + ' <br />  <b>' + "State:</b>" + obj['state'] + '</div>');

                            layerGroups.addLayer(marker);

                        }

                        layerGroups.addTo(map);

                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            }

        });
    </script>

    <style>
        #inputs {
            z-index: 10;
            top: 10px;
            left: 10px;
        }
    </style>
</head>
<body>
    <!-- ======= Header ======= -->
    <header id="header" class="fixed-top ">
        <div class="container">

            <div class="logo float-left">
                <h1 class="text-light" style="font-size: 30px"><a href="index.aspx"><span class="text-capitalize">Koala Go</span></a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
            </div>

            <nav class="nav-menu float-right d-none d-lg-block">
                <ul>
                    <li><a href="index.aspx">Home</a></li>
                    <li><a href="Volunteering.aspx">Volunteering</a></li>
                    <li><a href="Map.aspx">Koala Eye</a></li>

                    <li><a href="Information.aspx">Information</a></li>
                </ul>
            </nav>
            <!-- .nav-menu -->
        </div>
    </header>
    <!-- End Header -->
    <form>
        <main id="main" style="height: 100%; width: 100%;">

            <div class="row div_center_mapmove_up2" style="height: 100%;">
                <div class="col-md-1"></div>

                <div class="col-md-2 order-1 div_card4 " style="height: 100%;">

                    <h5><b>Koala Sighting </b></h5>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="allData" checked="checked" name="koala" value="Queensland">&nbsp;Hotspot Clusters

                 <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'> You will find the the highest number of Koala population in the areas.</p>" />

                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rALLState" name="koala" value="Queensland">&nbsp;Individual Sighting
                   <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'>You will see the every single Koala distribution in NSW & QLD, Koala sightings including the past sightings and recent sightings.<br /><img width='25' height='25'  src='Images/koalaLoc.png' /> -koala location marker <br /><img width='25' height='25'  src='Images/recentlySeen.png' / >-Recent Koala Location marker </p>" />

                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="cmbchoro" name="koala" value="Area Likelihood">&nbsp;Area Likelihood
                    <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'>You will find the most probable areas with high likelihood of Koalas presence.<br /> </p>" />
                    <br />
                    <hr />

                    <h5><b>Geo Functions</b></h5>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="GeoFunction1" name="function" value="Navigate">&nbsp;Navigate
                <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'> You can use navigate tool to choose different two points on map and checkout the distance and time spent between those selected points.</p>" />
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="GeoFunction2" name="function" value="Highlight Area">&nbsp;Highlight Area
                     <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'> Once you enter your location and choose the range, you will see all of the volunteering organisations and koala sightings in that range around you.</p>" />

                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input checked="checked" type="radio" id="GeoFunction3" name="function" value="Clear">&nbsp;Clear Functions
                     <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'>Clear all the controls in the page</p>" />

                    <div id="distanceval">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input checked="checked" type="radio" id="d5" name="distance" value="5000">5 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d10" name="distance" value="10000">10 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d20" name="distance" value="20000">20 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d50" name="distance" value="50000">50 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d100" name="distance" value="100000">100 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d200" name="distance" value="200000">200 km<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="d500" name="distance" value="500000">500 km<br />
                    </div>

                    <hr />
                    <h5><b>Past Fires</b></h5>
                    <input type="date" min='2020-01-01' id="txtdate" />
                    <button type="button" id="firebtn" class="btn btn-secondary">show</button>
                    <img class="test" src="Images/help.png" data-toggle="tooltip" data-placement="right" data-offset="20 0" data-html="true" title="<p class='myalign'>Display fire information for past date</p>" />

                    <br />
                    <h5><b>Legends</b></h5>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/fireIcon.png" width="25" height="25" />-Bushfire<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/pastfire.png" width="25" height="25" />-Past Bushfire<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/koalaHome.png" width="25" height="25" />-Volunteering Organisation<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/koalaLoc.png" width="25" height="25" />-Koala Location<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/recentlySeen.png" width="25" height="25" />-Recent Koala Location
                </div>

                <div class="col-sm-9 order-2 ">

                    <div id="map"></div>
                    <div id='inputs'></div>
                    <div id='directions'>
                        <div class="popuptext" id="myPopup"></div>
                    </div>
                </div>
            </div>
        </main>
    </form>

    <!-- ======= Footer ======= -->
    <footer id="footer" data-aos="fade-up" data-aos-easing="ease-in-out" data-aos-duration="500">

        <div class="footer-top">
            <div class="container">
                <div class="row">

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Volunteering</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="Volunteering.aspx">Find Volunteering Organisations</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="Volunteering.aspx">View Current Opportunities</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="Volunteering.aspx">Locate Koala Organisations</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Imformation</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="Information.aspx#koalainfo">Know About Koala</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="Information.aspx#bushfireinfo">Know About Bushfire</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="Information.aspx#datadetail">Know About Bushfire Effects On Koalas</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Koala Eye</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="Map.aspx">View Koala Locations</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="Map.aspx">Likelihood Map</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer -->

    <a href="#" class="back-to-top"><i class="icofont-simple-up"></i></a>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/jquery/jquery.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <script src="assets/vendor/venobox/venobox.min.js"></script>
    <script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
    <script src="assets/vendor/counterup/counterup.min.js"></script>
    <script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="assets/vendor/aos/aos.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
    <style>
        #inputs,
        #errors,
        #directions {
            position: absolute;
            width: 33.3333%;
            max-width: 300px;
            min-width: 200px;
        }

        #inputs {
            z-index: 10;
            top: 10px;
            left: 10px;
        }

        #directions {
            z-index: 99;
            background: rgba(0,0,0,.8);
            top: 0;
            right: 0;
            bottom: 0;
            overflow: auto;
        }

        #errors {
            z-index: 8;
            opacity: 0;
            padding: 10px;
            border-radius: 0 0 3px 3px;
            background: rgba(0,0,0,.25);
            top: 90px;
            left: 10px;
        }
    </style>

    <script src='https://api.mapbox.com/mapbox.js/plugins/mapbox-directions.js/v0.4.0/mapbox.directions.js'></script>
    <link rel='stylesheet' href='https://api.mapbox.com/mapbox.js/plugins/mapbox-directions.js/v0.4.0/mapbox.directions.css' type='text/css' />

    <script>
        var currlat;
        var currlon;
        navigator.geolocation.getCurrentPosition(function (location) {
            currlat = location.coords.latitude;
            currlon = location.coords.longitude;
        });
        if (currlat == null) {
            currlat = -29.833710;
        } if (currlon == null) {
            currlon = 148.32101;
        }
        //token for the map
        L.mapbox.accessToken = 'pk.eyJ1Ijoibm9ydTAwMDEiLCJhIjoiY2s5eXZwcms0MDgxdTNkczRiY2c0bmozdiJ9.x23fG3xIC_3n6J46ZXCLiA';
        var map = L.mapbox.map('map', null, {
            zoomControl: false
        })
            .setView([currlat, currlon], 5)
            .addLayer(L.mapbox.styleLayer('mapbox://styles/mapbox/streets-v11'));
        L.control.zoom({
            position: 'topright'
        }).addTo(map);

        L.control.scale({ position: 'bottomright' }).addTo(map);

        // move the attribution control out of the way
        map.attributionControl.setPosition('bottomleft');

        // create the initial directions object, from which the layer
        // and inputs will pull data.
        var directions = L.mapbox.directions();

        directionsLayer = L.mapbox.directions.layer(directions);

        directionsLayer.addTo(map);

        var directionsInputControl = L.mapbox.directions.inputControl('inputs', directions)
            .addTo(map);

        var directionsErrorsControl = L.mapbox.directions.errorsControl('errors', directions)
            .addTo(map);

        var directionsRoutesControl = L.mapbox.directions.routesControl('routes', directions)
            .addTo(map);

        var directionsInstructionsControl = L.mapbox.directions.instructionsControl('instructions', directions)
            .addTo(map);

        //var orgPoint = directions.getOrigin();
        //var destPoint = directions.getDestination();

        directions.on('load', function (e) {
            var origin = e.origin.geometry.coordinates;
            //var destination = e.destination.geometry.coordinates;
            // var path = [origin.reverse(), destination.reverse()];

            var fromlat = e.origin.geometry.coordinates[1];
            var fromlon = e.origin.geometry.coordinates[0];
            var tolat = e.destination.geometry.coordinates[1];
            var tolon = e.destination.geometry.coordinates[0];

            var distance = e.routes[0].distance;
            var duration = e.routes[0].duration;
            var disval = (distance / 1000).toFixed(2);;
            var dur_hours = Math.floor(duration / 3600);
            var dur_minutes = Math.floor((duration % 3600) / 60);
            //create a pop up for distance feature
            popup = L.popup()
                .setLatLng([origin[1], origin[0]])
                .setContent("<div><b>Distance:</b>" + disval + "km<br /><b>Duration:</b>" + dur_hours + "hours &nbsp;" + dur_minutes + 'minutes<br /><a href=https://www.google.com/maps/dir/' + fromlat + ',' + fromlon + '/' + tolat + ',' + tolon + '>Click here to enter the Google Map</a></div>')
                .openOn(map);

        });

        searchlayer = L.markerClusterGroup();

        var searchControl = L.esri.Geocoding.geosearch(
            {
                providers: [
                    L.esri.Geocoding.arcgisOnlineProvider({
                        countries: ['AUS']
                    })

                ]
            }

        ).addTo(map);

        function addSearch() {

            map.addControl(searchControl);
        } function removeSearch() {

            map.removeControl(searchControl);
        }

        //Setting fires in QA

        function setQAfires() {
            $.ajax({
                type: "POST",
                url: "Map.aspx/getFiresQA",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var json = JSON.parse(response.d);

                    QAfires = L.layerGroup();
                    var fireIcon = L.icon({
                        iconSize: [30, 30],
                        iconUrl: 'Images/fireIcon.png'

                    });

                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];
                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);
                        var date = String(obj['date']);
                        marker = new L.marker([lat, lon], { icon: fireIcon });
                        marker.bindPopup('<div>' + '<b>Reported:</b>' + date + '<br /><b>Alerttype:</b>' + obj['alerttype'] + '<br /><b>Reported:</b>' + obj['reported'] + '<br /><b>Status:</b>' + obj['status'] + '<br /><b>Details:</b>' + obj['details'] + '<br /><b>State:</b>' + obj['state'] + '</div>');
                        QAfires.addLayer(marker);

                    }
                    //adding fire layer to the map
                    QAfires.addTo(map);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        //End of Setting Fire data for QA
        function setNSWfires() {
            //Setting fires in NSW
            $.ajax({
                type: "POST",
                url: "Map.aspx/getFiresNSW",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var json = JSON.parse(response.d);
                    //  alert(json);

                    // alert('xxx');
                    NSWfires = L.layerGroup();
                    var fireIcon = L.icon({
                        iconSize: [30, 30],
                        iconUrl: 'Images/fireIcon.png'

                    });
                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];
                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);
                        var date = String(obj['date']);
                        marker = new L.marker([lat, lon], { icon: fireIcon });
                        marker.bindPopup('<div><b>Date:</b>' + date + '<br /><b>Alerttype:</b>' + (obj['alerttype']) + '<br /><b>Location:</b>' + obj['location'] + '<br /><b>Council:</b>' + obj['council'] + '<br /><b>Status:</b>' + obj['status'] + '<br /><b>ResponsibleAgency:</b>' + obj['responsibleAgency'] + '<br /><b>State:</b>' + obj['state'] + '</div>');
                        NSWfires.addLayer(marker);

                    }
                    //adding fire layer to the map
                    map.addLayer(NSWfires);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }
        //End of Setting Fire data for NSW

        getKoalaOrganisations();
        function getKoalaOrganisations() {
            //Diaplying Koala Organisations
            $.ajax({
                type: "POST",
                url: "Map.aspx/getKoalaOrganisations",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var json = JSON.parse(response.d);

                    orglayer = L.layerGroup();
                    var shelterIcon = L.icon({
                        iconSize: [40, 40],
                        iconUrl: 'Images/koalaHome.png'

                    });
                    var shelterIcon2 = L.icon({
                        iconSize: [40, 40],
                        iconUrl: 'Images/koalaHome.png'

                    });

                    // alert('3333');
                    for (var ii = 0; ii < json.length; ii++) {
                        var obj = json[ii];

                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);

                        if (count == 0) {
                            //creating a marker
                            marker = new L.marker([lat, lon], { icon: shelterIcon });

                        }
                        else {

                            for (var i = 0; i < mylat.length; i++) {
                                var lat1 = mylat[i];
                                var lon1 = mylon[i];
                                var dis = calDistance(lat1, lon1, lat, lon);
                                if (dis <= mydis[i] / 1000) {
                                    //creating a marker with bouncing
                                    marker = new L.marker([lat, lon], { icon: shelterIcon2 }).setBouncingOptions({
                                        bounceHeight: 60,   // height of the bouncing
                                        bounceSpeed: 54,   // bouncing speed coefficient
                                    });
                                    marker.toggleBouncing();

                                }
                            }
                        }

                        var a = obj['opportunities'];
                        var opportunity = a.split('~');

                        var result = '<p><b>Opportunities</b></p>';
                        opportunity.forEach(function (entry) {
                            if (result == '') {
                                result = ' ' + entry + ' <br />';
                            }
                            else {
                                result = result + '  ' + entry + ' <br />';
                            }
                        });

                        //alert(opportunity[0]);
                        var len = mylat.length;

                        marker.bindPopup('<div><b>Name:</b>' + (obj['orgname']) + '<br /><b>Website:</b><a href=' + (obj['website']) + '>' + (obj['website']) + '</a><br /><b>Address:</b>' + obj['address'] + '<br /><b>Description:</b>' + obj['desc'] + '\n' + result + '</div>');
                        orglayer.addLayer(marker);

                    }

                    map.addLayer(orglayer);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });

        }
        //calculate the distance between given two markers
        function calDistance(lat1, lon1, lat2, lon2) {
            var R = 6371; // km
            var dLat = toRad(lat2 - lat1);
            var dLon = toRad(lon2 - lon1);
            var lat1 = toRad(lat1);
            var lat2 = toRad(lat2);

            var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            var d = R * c;
            return d;
        }

        // Converts numeric degrees to radians
        function toRad(Value) {
            return Value * Math.PI / 180;
        }

        function getOpprtunities(item, index, arr) {

        }

        var results = L.layerGroup().addTo(map);
        var icon_home = L.icon({

            iconUrl: 'Images/home.png',
            iconSize: [40, 40]

        });
        //adding a circle after seaching address and highlighting that area
        searchControl.on('results', function (data) {
            //creating layer group if requred
            if (circlelayer != null) {
                // map.removeLayer(circlelayer);
            }
            else {
                circlelayer = L.layerGroup()
            }
            results.clearLayers();
            for (var i = data.results.length - 1; i >= 0; i--) {

                var marker = L.marker(data.results[i].latlng, { icon: icon_home });

                marker.bindPopup('<div>' + 'Home' + '<\div> ');

                var co = data.results[i].latlng + '';
                var co1 = co.split(',');

                var co2 = co1[1] + '';
                var co3 = co2.split(')');

                var co4 = co1[0].split('(');

                var circleCenter = [co4[1], co3[0]];//setting lat lon values
                //definin different colors for different circled to be added
                var circleOptions1 = {
                    color: '#3388FF',
                    fillColor: '#92C4E5',
                    fillOpacity: 0.3
                }
                var circleOptions2 = {
                    color: '#008000',
                    fillColor: '#B2E181',
                    fillOpacity: 0.3
                }

                var circleOptions3 = {
                    color: '#FF4500',
                    fillColor: '#FF7F50',
                    fillOpacity: 0.3
                }

                var circleOptions4 = {
                    color: '#8B4513',
                    fillColor: '#D2B48C',
                    fillOpacity: 0.3
                }
                var circleOptions5 = {
                    color: '#C71585',
                    fillColor: '#FF69B4',
                    fillOpacity: 0.3
                }

                //var circle = L.circle(circleCenter, 50000, circleOptions);
                //circle.addTo(map);
                //alert('ssss');
                var distance;

                if ($('#d5').is(':checked')) {
                    distance = $('#d5').val();
                }
                else if ($('#d10').is(':checked')) {
                    distance = $('#d10').val();
                } else if ($('#d20').is(':checked')) {
                    distance = $('#d20').val();
                } else if ($('#d50').is(':checked')) {
                    distance = $('#d50').val();
                } else if ($('#d100').is(':checked')) {
                    distance = $('#d100').val();
                } else if ($('#d200').is(':checked')) {
                    distance = $('#d200').val();
                } else if ($('#d500').is(':checked')) {
                    distance = $('#d500').val();
                }

                circlelayer.addLayer(marker);
                //alert('ddd'+distance);
                //results.addLayer(marker);

                var val = count % 5;
                val = val + 1;
                var optionsval;
                if (val == 1)
                    optionsval = circleOptions1;
                else if (val == 2)
                    optionsval = circleOptions2;
                else if (val == 3)
                    optionsval = circleOptions3;
                else if (val == 4)
                    optionsval = circleOptions4;
                else if (val == 5)
                    optionsval = circleOptions5;
                circlelayer.addLayer(new L.circleMarker([co4[1], co3[0]], { radius: parseInt(distance) / 1000 }, optionsval));
                //L.circle([co4[1], co3[0]], parseInt(distance), optionsval).addTo(map);

                mylat[count] = co4[1];
                mylon[count] = co3[0];
                mydis[count] = distance;
                getKoalaOrganisations();
                circlelayer.addTo(map);

                count++;

                break;
            }
        });

        // L.control.ruler().addTo(map);

        displayMapWithLocationCount();

        //Display clustered koala information
        function displayMapWithLocationCount() {

            $.ajax({
                type: "POST",
                url: "Map.aspx/getKoalaInfo",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var json = JSON.parse(response.d);

                    var someFeatures = new String("");
                    var count = 0;
                    clusters = L.markerClusterGroup();
                    var koalaLoc1 = L.icon({
                        iconSize: [40, 40],
                        iconUrl: 'Images/koalaLoc.png'

                    });

                    var iconRecentlySeen = L.icon({
                        iconSize: [30, 30],
                        iconUrl: 'Images/recentlySeen.png'

                    });
                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];

                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);

                        // marker.addTo(map);
                        var fe;
                        fe = "<div><b>State: </b>" + obj['state'] + '<br /> <b>Date_found: </b>' + obj['datefound'] + '</div>';
                        //alert('count' + count);

                        var marker;

                        if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                            marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                        }
                        else {
                            marker = new L.marker([lat, lon], { icon: koalaLoc1 });
                        }

                        marker.bindPopup(fe);
                        clusters.addLayer(marker);

                    }

                    map.addLayer(clusters);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });

        }

        function displayPastFireInformation() {

            var obj = {};
            obj.date1 = $.trim($("[id*=txtdate]").val());

            $.ajax({
                type: "POST",
                url: "Map.aspx/displayPastFireInformation",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var json = JSON.parse(response.d);

                    var someFeatures = new String("");
                    var count = 0;
                    pastFires = L.layerGroup();
                    var fire2 = L.icon({
                        iconSize: [25, 25],
                        iconUrl: 'Images/pastfire.png'

                    });

                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];

                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);

                        // marker.addTo(map);
                        var fe;
                        fe = "<div><b>Alert Type: </b>" + obj['alerttype'] + '<br /> <b>Status: </b>' + obj['status'] + '<br /> <b>Details: </b>' + obj['details'] + '</div>';

                        var marker;
                        marker = new L.marker([lat, lon], { icon: fire2 });
                        marker.bindPopup(fe);
                        pastFires.addLayer(marker);

                    }

                    map.addLayer(pastFires);

                },
                failure: function (response) {
                    alert(response.d);
                }
            });

        }

        function getCurrentYearMonth() {

            var today = new Date();
            var month = (today.getMonth() + 1);
            if (month < 10) month = '0' + month;

            var yearMonth = today.getFullYear() + '' + month;
            return yearMonth;

        }

        function getYearMonthGivenDate(val) {

            var res = val.substring(0, 4) + val.substring(5, 7);
            return res;

        }

        function checkIsRecentlySeenLocation(dateseen) {
            var currmonth = getCurrentYearMonth();
            var ds = getYearMonthGivenDate(dateseen);
            var newval = currmonth - 1;
            if (newval <= ds) {
                return 1;
            }
            else {
                return 0;
            }

        }

        function getColor(d) {
            return d >= 300 ? '#800026' :
                d >= 200 ? '#bd0026' :
                    d >= 100 ? '#E31A1C' :
                        d >= 50 ? '#FC4E2A' :
                            d >= 30 ? '#FD8D3C' :
                                d >= 10 ? '#FEB24C' :
                                    d >= 1 ? '#FED976' :
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
        function loadsecondMap() {

            geojson = L.geoJson(suburbGeo, {
                style: style,
                onEachFeature: onEachFeature
            }).addTo(map);

            info.onAdd = function (map) {
                this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
                this.update();
                return this._div;
            };
            // method that we will use to update the control based on feature properties passed
            info.update = function (props) {
                this._div.innerHTML = '<h4>Koala population</h4>' + (props ?
                    '<b>' + props.suburb + '</b><br />' + props.count + ' koala records</b><br />Most probable month: ' + props.month + '<sup></sup>'
                    : 'Hover over Hotspots');
            };

            info.addTo(map);
            legend = L.control({ position: 'bottomright' });
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
            addInfo();
            addlegend();
        }

        function addlegend() {

            map.addControl(legend);
        } function removelegend() {
            if (legend != null)
                map.removeControl(legend);
        }

        function addInfo() {

            map.addControl(info);
        } function removeInfo() {
            if (info != null)
                map.removeControl(info);
        }
        //focussing the user's current location when logged in
        navigator.geolocation.getCurrentPosition(function (location) {
            currlat = location.coords.latitude;
            currlon = location.coords.longitude;
            if (currlat != null && currlon != null)
                map.setView([currlat, currlon], 12);
        });
    </script>
</body>
</html>