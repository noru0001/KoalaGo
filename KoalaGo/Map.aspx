<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="KoalaGo.Map" %>

<html>
<head>
    <meta charset="utf-8" />
    <title>Driving directions</title>

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
    <style>
        #map {
            height: 100%;
        }
    </style>

    <script>
        var clusters;
        var layerGroups;
        var circlelayer;
        var count = 0;
        var firelayer;
        var orglayer;
        var sakoala;
        var vickoala;
        var nswkoala;
        var qldkoala;
        var QAfires;
        var NSWfires;
        var searchlayer;
        var popup;
        var directionsLayer;
        var directionsInputControl;
        var mylat = [];
        var mylon = [];
        var mydis = [];

        $(document).ready(function () {
            $("#distanceval").hide();
            $("#inputs").hide();
            $("#myPopup").hide();
            $("#directions").hide();

            if (searchlayer != null)
                map.removeLayer(searchlayer);

            $("#inputs").click(function () {

                map.closePopup();
            });

            $("#GeoFunction1").click(function () {
                //if (directionsLayer != null) {
                //    map.removeLayer(directionsLayer);
                //}

                $("#distanceval").hide();
                $("#inputs").show();
                removeSearch();
                map.closePopup();
                circlelayer = L.layerGroup()
                map.addLayer(circlelayer);
                  
            });

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
            $("#GeoFunction3").click(function () {
              
                location.reload();
               

            });

            $('#mySelect').change(function () {
                var value = $(this).val();
            });

            //$("#rSA").click(function () {

            //    if (layerGroups != null) {
            //        map.removeLayer(layerGroups);

            //    }

            //    if (clusters != null)

            //        map.removeLayer(clusters);

            //    FilteredMapByState();
            //});

            $("#rQLD").click(function () {

                if (layerGroups != null) {
                    map.removeLayer(layerGroups);
                }
                if (clusters != null)

                    map.removeLayer(clusters);

                FilteredMapByState();
            });

            $("#rNSW").click(function () {

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                FilteredMapByState();
            });
            //$("#rVIC").click(function () {

            //    if (layerGroups != null)
            //        map.removeLayer(layerGroups);

            //    if (clusters != null)

            //        map.removeLayer(clusters);

            //    FilteredMapByState();
            //});
            $("#rALLState").click(function () {

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                FilteredMapByState();
            });

            $("#allData").click(function () {

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                if (clusters != null)

                    map.removeLayer(clusters);

                displayMapWithLocationCount();

            });

            setQAfires();
            setNSWfires();

            $("#rNSW1").click(function () {
                if (NSWfires != null) { map.removeLayer(NSWfires); }
                if (QAfires != null) { map.removeLayer(QAfires); }

                setNSWfires();
            });

            $("#rQLD1").click(function () {
                if (NSWfires != null) { map.removeLayer(NSWfires); }
                if (QAfires != null) { map.removeLayer(QAfires); }

                setQAfires();
            });

            $("#rALLState1").click(function () {
                if (NSWfires != null) { map.removeLayer(NSWfires); }
                if (QAfires != null) { map.removeLayer(QAfires); }

                setQAfires();
                setNSWfires();
            });
            $("#rclearBushfires").click(function () {
                if (NSWfires != null) { map.removeLayer(NSWfires); }
                if (QAfires != null) { map.removeLayer(QAfires); }

            });

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
            function FilteredMapByState() {
                if (clusters != null)

                    map.removeLayer(clusters);

                if (layerGroups != null)
                    map.removeLayer(layerGroups);

                $.ajax({
                    type: "POST",
                    url: "MapsInformation.aspx/getKoalaInfo",
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

                        var koalaLoc1 = L.icon({
                            iconSize: [40, 40],
                            iconUrl: 'Images/koalaLoc.png'

                        });

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
                            v = 0;

                            //if (obj['state'] == 'VIC' && (($("#rVIC").is(":checked"))) || isAll == 1) {
                            //    // checked

                            //    if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                            //        marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                            //    }
                            //    else {

                            //        marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                            //    }
                            //    marker.bindPopup('<div>' + '<b>Last seen on:</b>' + ' ' + obj['datefound'] + ' <br />  <b>' + "State:</b>" + obj['state'] + '</div>');

                            //    v = 1;

                            //}
                            //else
                            if (obj['state'] == 'NSW' && (($("#rNSW").is(":checked"))) || isAll == 1) {

                                if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                                    marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                                }
                                else {
                                    marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                                }

                                marker.bindPopup('<div>' + '<b>Last seen on:</b>' + ' ' + obj['datefound'] + ' <br />  <b>' + "State:</b>" + obj['state'] + '</div>');

                                v = 2;
                                //alert('nsw' + marker);
                            }

                            else if (obj['state'] == 'QLD' && (($("#rQLD").is(":checked"))) || isAll == 1) {

                                if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                                    marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                                }
                                else {
                                    marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                                }
                                marker.bindPopup('<div>' + '<b>Last seen on:</b>' + ' ' + obj['datefound'] + ' <br />  <b>' + "State:</b>" + obj['state'] + '</div>');

                                v = 3;
                                // alert('a33');

                            }
                            //else if (obj['state'] == 'SA' && (($("#rSA").is(":checked"))) || isAll == 1) {
                            //    v = 4;
                            //    if (checkIsRecentlySeenLocation(obj['datefound']) == 1) {

                            //        marker = new L.marker([lat, lon], { icon: iconRecentlySeen });

                            //    }
                            //    else {
                            //        marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                            //    }
                            //    marker.bindPopup('<div>' + '<b>Last seen on:</b>' + ' ' + obj['datefound'] + ' <br />  <b>' + "State:</b>" + obj['state'] + '</div>');

                            //}

                            //else {
                            //    marker = new L.marker([lat, lon]);
                            //    marker.bindPopup('<div>' + 'Last seen on:' + ' ' + obj['datefound'] + '<br /> ' + "State:" + obj['state'] + ' ' + 'lat' + obj['lat'] + ' lon' + obj['lon']+'</div>');

                            //    layerGroups.addTo(marker);

                            //}

                            if (v >= 2 && v <= 3)
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
                    <li class="active"><a href="index.aspx">Home</a></li>
                    <li><a href="Volunteering.aspx">Volunteering</a></li>
                    <li class="drop-down"><a>Map</a>
                        <ul>
                            <li><a href="Map.aspx">Location Map</a></li>
                            <li><a href="ChoroplethMap.aspx">Choropleth Map</a></li>
                        </ul>
                    </li>
                    <li><a href="Information.aspx">Information</a></li>
                </ul>
            </nav>
            <!-- .nav-menu -->
        </div>
    </header>
    <!-- End Header -->

    <main id="main" style="height: 100%; width: 100%;">

        <form runat="server">

            <div class="row div_center_mapmove_up2" style="height: 100%;">
                <div class="col-md-1"></div>

                <div class="col-md-2 order-1 div_card4 " style="height: 100%;">

                    <h5><b>Koala Distribution </b></h5>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rNSW" name="koala" value="New south wales">New south wales<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rQLD" name="koala" value="Queensland">Queensland<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rALLState" name="koala" value="Queensland">Both States<br />
                    <input type="radio" id="allData" checked="checked" name="koala" value="Queensland">Click here to show count<br />
                    <hr />
                    <h5><b>Bushfire Distribution</b></h5>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rNSW1" name="bush1" value="New south wales">New south wales<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rQLD1" name="bush1" value="Queensland">Queensland<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" checked="checked" id="rALLState1" name="bush1" value="Queensland">Both States<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="rclearBushfires" name="bush1" value="Queensland">Clear Bushfires<br />
                    <hr />

                    <h5><b>Geo Functions</b></h5>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="GeoFunction1" name="function" value="Navigate">Navigate<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="GeoFunction2" name="function" value="Highlight Area">Highlight Area<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input checked="checked" type="radio" id="GeoFunction3" name="function" value="Clear">Clear Functions

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
                    <h5><b>Legends</b></h5>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/fireIcon.png" width="25" height="25" />-Bushfire<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/koalaHome.png" width="25" height="25" />-Koala Organisation<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/koalaLoc.png" width="25" height="25" />-Koala Location<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="Images/recentlySeen.png" width="25" height="25" />-Recent Koala Location
                </div>

                <div class="col-sm-9 order-2 ">

                    <div id="map"></div>
                    <div id='inputs'></div>
                    <div id='directions'>
                        <div class="popuptext" id="myPopup">A Simple Popup!</div>
                    </div>
                </div>
            </div>
        </form>
    </main>

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
                            <li><i class="bx bx-chevron-right"></i><a href="Information.aspx#datadetail">Kow About Bushfire Affects on Koalas</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Koala Eye</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="Map.aspx">View Koala Locations</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="ChoroplethMap.aspx">View Choropleth Map</a></li>
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
        L.mapbox.accessToken = 'pk.eyJ1Ijoibm9ydTAwMDEiLCJhIjoiY2s5eXZwcms0MDgxdTNkczRiY2c0bmozdiJ9.x23fG3xIC_3n6J46ZXCLiA';
        var map = L.mapbox.map('map', null, {
            zoomControl: false
        })
            .setView([-29.833710, 148.321011], 5)
            .addLayer(L.mapbox.styleLayer('mapbox://styles/mapbox/streets-v11'));
        L.control.zoom({
            position: 'topright'
        }).addTo(map);
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

        //var searchControl = L.esri.Geocoding.geosearch();
        // searchlayer.addLayer(searchControl);
        //map.addLayer(searchControl);
        //Setting fires in QA
        function setQAfires() {
            $.ajax({
                type: "POST",
                url: "MapsInformation.aspx/getFiresQA",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var json = JSON.parse(response.d);
                    //  alert(json);

                    // alert('xxx');
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
                        //  var date = String(obj['date']);
                        //marker = new L.marker([lat, lon], { icon: shelterIcon });

                        // marker = new L.marker([lat, lon], { icon: shelterIcon });
                        //alert('rrr');
                        // alert(count);
                        if (count == 0) {
                            //   alert('0000');
                            marker = new L.marker([lat, lon], { icon: shelterIcon });
                            // alert('aaaaa');
                        }
                        else {

                            //alert('bbbb');
                            for (var i = 0; i < mylat.length; i++) {
                                var lat1 = mylat[i];
                                var lon1 = mylon[i];
                                var dis = calDistance(lat1, lon1, lat, lon);
                                if (dis <= mydis[i] / 1000) {

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

        searchControl.on('results', function (data) {
            //alert('count='+count);
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

                //var draw = new MapboxDraw({
                //    displayControlsDefault: false,
                //    controls: {
                //        polygon: true,
                //        trash: true
                //    }
                //});

                count++;
                break;
            }
        });

        // L.control.ruler().addTo(map);

        displayMapWithLocationCount();

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
                    for (var i = 0; i < json.length; i++) {
                        var obj = json[i];

                        // Adding marker to the map
                        var lat = parseFloat(obj['lat']);
                        var lon = parseFloat(obj['lon']);

                        // marker.addTo(map);
                        var fe;
                        fe = "<div><b>State: </b>" + obj['state'] + '<br /> <b>Date_found: </b>' + obj['datefound'] + '</div>';
                        //alert('count' + count);

                        var marker = new L.marker([lat, lon], { icon: koalaLoc1 });

                        // var marker = L.marker(new L.LatLng(lat, lon), { title: title }, { icon: koalaLoc1 });
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
    </script>
</body>
</html>