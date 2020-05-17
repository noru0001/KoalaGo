<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChoroplethMap.aspx.cs" Inherits="KoalaGo.ChoroplethMap" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Choropleth Map</title>

    <meta charset="utf-8" />
    <link rel="stylesheet" href="leaflet/leaflet.css" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.js"></script>
    <script src="leaflet/leaflet.js"></script>
    <script src="choroplethmap/suburbgeo.js"></script>
    <script src="choroplethmap/density.js"></script>
    <script src="choroplethmap/propableMonth.js"></script>
    <link rel="stylesheet" type="text/css" href="choroplethmap/style.css" />

    <link href="assets/img/favicon.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Roboto:300,300i,400,400i,500,500i,700,700i&display=swap" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
    <link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
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

    <main id="main">
        <div class="container">
            <div class="row" style="margin-top: 100px; margin-bottom: 100px">
                <div class="col-lg-3">
                    <div class="row">
                        <h4 class="wrapper-demo">Select Year</h4>
                        <input id="chooseyear" class="year-from form-control" style="width: 200px; margin-top: 10px" type="text">
                        <script type="text/javascript">
                            $('.year-from').datepicker({
                                minViewMode: 2,
                                format: 'yyyy',
                                startDate: '1990',
                                endDate: '2019',
                                autoclose: true
                            });
                        </script>
                    </div>
                    <div class="row">
                        <div class="wrapper-demo">
                            <div id="dd" class="wrapper-dropdown-1" tabindex="1">
                                <span>Month</span>
                                <ul class="dropdown" tabindex="1">
                                    <li><a href="#">January</a></li>
                                    <li><a href="#">February</a></li>
                                    <li><a href="#">March</a></li>
                                    <li><a href="#">April</a></li>
                                    <li><a href="#">May</a></li>
                                    <li><a href="#">June</a></li>
                                    <li><a href="#">July</a></li>
                                    <li><a href="#">August</a></li>
                                    <li><a href="#">September</a></li>
                                    <li><a href="#">October</a></li>
                                    <li><a href="#">November</a></li>
                                    <li><a href="#">December</a></li>
                                </ul>
                            </div>
                            ​
                        </div>
                    </div>
                    <div class="row">
                        <button class="wrapper-demo" style="width: 100px; height: 40px" onclick="refreshMap()">refresh</button>
                    </div>
                </div>
                <div id="map" class="col-lg-9" style="margin-bottom: 50px; margin-top: 50px"></div>
            </div>
        </div>

        <script>
            var xyear = 0;
            var xmonth = 0;
            var mapboxAccessToken = 'pk.eyJ1Ijoid2F5bmVzaGVuZ3l1YW4iLCJhIjoiY2thNm56cm9jMGFzMzJyb3p0c2sxaGhkdiJ9.SWUZj_CQm6jsemueIW_zzw';
            var map = L.map('map').setView([-28, 149], 6);

            L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=' + mapboxAccessToken, {
                id: 'mapbox/light-v10',
                attribution: '',
                tileSize: 512,
                zoomOffset: -1
            }).addTo(map);

            function getColor(d) {
                return d >= 100 ? '#800026' :
                    d >= 50 ? '#bd0026' :
                        d >= 30 ? '#E31A1C' :
                            d >= 20 ? '#FC4E2A' :
                                d >= 10 ? '#FD8D3C' :
                                    d >= 5 ? '#FEB24C' :
                                        d >= 1 ? '#FED976' :
                                            'rgba(255,237,160,0)';
            }
            function style(feature) {
                var suburb = feature.properties.suburb;
                var state = feature.properties.state;
                return {
                    fillColor: getColor(koalacount(state, suburb)),
                    weight: 2,
                    opacity: 1,
                    color: 'white',
                    dashArray: '3',
                    fillOpacity: 0.7
                };
            }

            function koalacount(sState, sSuburb) {
                var koalaCount = 0;
                for (i = 0; i < densityData.length; i++) {
                    if (densityData[i].suburb_name.toUpperCase() == sSuburb && densityData[i].state == sState && densityData[i].year == xyear && densityData[i].month == xmonth) {
                        koalaCount = densityData[i].cc;
                    }
                }
                return koalaCount;
            }

            function propableMon(sState, sSuburb) {
                var pMonth = "undefined";
                for (i = 0; i < aMonth.length; i++) {
                    if (aMonth[i].state == sState && aMonth[i].suburb_name.toUpperCase() == sSuburb) {
                        pMonth = aMonth[i].Month;
                    }
                }
                return pMonth;
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
                    click: zoomToFeature
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
                this._div.innerHTML = '<h4>Koala population</h4>' + (props ?
                    '<b>' + props.suburb + '</b><br />' + koalacount(props.state, props.suburb) + ' koala records</b><br />Most probable month: ' + propableMon(props.state, props.suburb) + '<sup></sup>'
                    : 'Hover over NSW or QLD');
            };

            info.addTo(map);

            var legend = L.control({ position: 'bottomright' });

            legend.onAdd = function (map) {

                var div = L.DomUtil.create('div', 'info legend'),
                    grades = [0, 1, 5, 10, 20, 30, 50, 100],
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

            function refreshMap() {
                xyear = Number(document.getElementById("chooseyear").value);
                if (xyear == 0 || xmonth == 0) {
                    window.alert("Please input year and month")
                    return;
                }
                map.remove();
                map = L.map('map').setView([-28, 149], 6);

                L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=' + mapboxAccessToken, {
                    id: 'mapbox/light-v10',
                    attribution: '',
                    tileSize: 512,
                    zoomOffset: -1
                }).addTo(map);
                geojson = L.geoJson(suburbData, {
                    style: style,
                    onEachFeature: onEachFeature
                }).addTo(map);
                info.addTo(map);
                legend.addTo(map);
            }
        </script>

        <script type="text/javascript">
            var monthchange = { 'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6, 'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12 }

            function DropDown(el) {
                this.dd = el;
                this.placeholder = this.dd.children('span');
                this.opts = this.dd.find('ul.dropdown > li');
                this.val = '';
                this.index = -1;
                this.initEvents();
            }

            DropDown.prototype = {
                initEvents: function () {
                    var obj = this;
                    obj.dd.on('click', function (event) {
                        $(this).toggleClass('active');
                        return false;
                    });
                    obj.opts.on('click', function () {
                        var opt = $(this);
                        obj.val = opt.text();
                        obj.index = opt.index();
                        obj.placeholder.text('Month: ' + obj.val);
                        xmonth = monthchange[obj.val];
                    });
                },

                getValue: function () {
                    return this.val;
                },

                getIndex: function () {
                    return this.index;
                }
            }
            $(function () {
                var dd = new DropDown($('#dd'));
                $(document).click(function () {
                    $('.wrapper-dropdown-1').removeClass('active');

                });
            });
        </script>
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
</body>
</html>