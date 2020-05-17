<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KoalaHome.aspx.cs" Inherits="KoalaGo.Home2" %>

<html>
<head>
    <title>A Leaflet map!</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="leaflet/leaflet.css" rel="stylesheet" />
    <link href="Content/MarkerCluster.css" rel="stylesheet" />
    <link href="Content/MarkerCluster.Default.css" rel="stylesheet" />
    <link href="Content/leaflet-ruler.css" rel="stylesheet" />

    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <script src="Scripts/bootstrap.min.js"></script>
    <script src="leaflet/leaflet.js"></script>

    <script src="leaflet/leaflet-providers.js"></script>

    <script src="leaflet/leaflet.markercluster.js"></script>

    <script src="https://npmcdn.com/leaflet-geometryutil"></script>

    <script src="Scripts/leaflet-ruler.js"></script>
    <style>
        #map {
            height: 80%
        }
    </style>

    <script>
</script>
</head>
<body>

    <form runat="server">

        <div class="container div_move_upmain">

            <div class="row ">

                <div class="col-md-12 " style="text-align: left;">
                    <nav class="navbar navbar-default ">
                        <div class="container-fluid" style="background-color: #E3E3E3;">

                            <ul class="nav navbar-nav">
                                <li class="active">
                                    <img src="Images/logo.jpg" class="img-responsive " />
                                </li>
                                <li><a href="./KoalaHome.aspx">Home</a></li>

                                <li><a href="./MapsInformation.aspx">Maps</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>

            <div class="row div_move_up">
                <%-- <div class="col-md-1"></div>--%>
                <div class="col-md-12 mytextOnimg">
                    <%--<div class="jumbotron img-responsive" style="background:url('./Images/koala.jpg')">
                      <p class="vertical-center" style="color:white;"><strong>Lets Help Koalas</strong></p>--%>
                    <%-- </div>  --%>
                    <img src="Images/koala.jpg" class="img-responsive img-thumbnail rounded " />
                    <div class="text">
                        <h1>Lets Help Koalas</h1>
                    </div>
                </div>

                <%--<div class="col-md-1"></div>--%>

                <div></div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <div class="div_card1 div_center_move_up">
                        <h3><strong>This website is dedicated to </br> protecting koalas in the NSW</strong></h3>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <img src="Images/koala1.jpg" class="img-responsive img-thumbnail rounded " />
                </div>
                <div class="col-md-6" style="text-align: justify;">
                    <h3>Koalas are uniquely in Australia</h3>
                    <p>The koala is an arboreal herbivorous marsupial native to Australia. </p>

                    <p>It is the only extant representative of the family Phascolarctos and its closest living relatives are the wombats, which comprise the family Vombatidae. </p>

                    <p>The koala is found in coastal areas of the mainland's eastern and southern regions, inhabiting Queensland, New South Wales, Victoria, and South Australia.</p>

                    <asp:Button runat="server" CssClass="button1 btn-sm alignbottom" Text="LearnMore" />
                </div>
            </div>

            <div class="row">

                <div class="col-md-6" style="text-align: justify;">
                    <br />
                    <p>The pervasive smoke haunting our towns and cities, the red skies turning black, the thunderous raw and thick smoke that accompanied the wall of flames and the utter devastation." </p>

                    <p>In addition to the loss of life, more than 10 million hectares were burned across Australia during the 2019-20 bushfire season, destroying 3,000 homes and 7,000 outbuildings. Millions of native plants and animals and 80,000 livestock died.</p>
                    <p>
                        The harrowing experiences of this bushfire season will long linger in Australian national psyche.
                    </p>

                    <br />
                    <asp:Button runat="server" CssClass="button2 btn-sm alignbottom" Text="LearnMore" />
                </div>

                <div class="col-md-6">
                    <img src="Images/bushfire.jpg" class="img-responsive img-thumbnail rounded " />
                </div>
            </div>

            <div class="row">

                <div class="col-md-12">

                    <div class="div_card2">
                        <h3><strong>Koala Distribution in NSW</strong></h3>
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-md-12">

                    <div id="map"></div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">

                    <%--<div class="div_card1 div_center_move_up">--%>
                    <div class=" col-md-2 div_card3 div_center_move_up2">
                        <h5><strong>See more koalas</strong></h5>
                        <asp:Button runat="server" CssClass="button1 btn-sm alignbottom" Text="ViewMore" />
                    </div>
                </div>
            </div>

            <div class="container">

                <div class="row div_green">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-3" style="text-align: center;">
                        <h1 style="color: white"><strong>13,000 </strong></h1>

                        <h5 style="color: white">Koalas have been rescued<br />
                            since 2000</h5>
                    </div>

                    <div class="col-sm-3" style="text-align: center;">
                        <h1 style="color: white"><strong>40% </strong></h1>

                        <h5 style="color: white">of rescued koalas were<br />
                            released back into the wild</h5>
                    </div>

                    <div class="col-sm-3" style="text-align: center;">
                        <h1 style="color: white"><strong>26% </strong></h1>

                        <h5 style="color: white">the estimated decline of the<br />
                            New South Wales koala<br />
                            population in the last two<br />
                            decades
                        </h5>
                    </div>

                    <div class="col-sm-1"></div>
                </div>

                <p>
                    Distance (in pixel): <span id="distance"></span>
                </p>
            </div>
        </div>
    </form>

    <!-- ======= Footer ======= -->
    <footer id="footer" data-aos="fade-up" data-aos-easing="ease-in-out" data-aos-duration="500">

        <div class="footer-top">
            <div class="container">
                <div class="row">

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Volunteering</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="volunteer.html">Find Volunteering Organisations</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="volunteer.html">View Current Opportunities</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="map.html">Locate Koala Organisations</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Imformation</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="info.html#koalainfo">Know About Koala</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="info.html#bushfireinfo">Know About Bushfire</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="info.html#datadetail">Kow About Bushfire Affects on Koalas</a></li>
                        </ul>
                    </div>

                    <div class="col-lg-4 col-md-6 footer-links">
                        <h4>Maps</h4>
                        <ul>
                            <li><i class="bx bx-chevron-right"></i><a href="map.html">View Koala Locations</a></li>
                            <li><i class="bx bx-chevron-right"></i><a href="choroplethMap.html">View Choropleth Map</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer -->
    <script>
        var map = L.map('map').setView([-27.111712, 135.573946], 4);

        // load a tile layer
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            {
                attribution: 'Tiles by <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors">MAPC</a>, Data by <a href="http://mass.gov/mgis">MassGIS</a>',
                maxZoom: 15,
                minZoom: 1
            }).addTo(map);

        L.control.ruler().addTo(map);

        $.ajax({
            type: "POST",
            url: "KoalaHome.aspx/getKoalaInfo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {

                var json = JSON.parse(response.d);
                var a = "";

                // var layerGroup;

                // alert("len=" + json.length);

                var someFeatures = new String("");
                var count = 0;
                for (var i = 0; i < json.length; i++) {
                    var obj = json[i];

                    // Adding marker to the map
                    var lat = parseFloat(obj['lat']);
                    var lon = parseFloat(obj['lon']);
                    marker = new L.marker([lat, lon]);
                    marker.addTo(map);

                }
            },

            failure: function (response) {
                alert(response.d);
            }
        });
    </script>
</body>
</html>