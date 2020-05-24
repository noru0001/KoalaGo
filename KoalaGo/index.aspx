<%@ Page Language="C#" CodeBehind="index.aspx.cs" Inherits="KoalaGo.index" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Moderna Bootstrap Template - Index</title>
    <meta content="" name="descriptison">
    <meta content="" name="keywords">

    <!-- Favicons -->
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

    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <script src="Scripts/bootstrap.min.js"></script>
    <script src="leaflet/leaflet.js"></script>
    <script src="leaflet/leaflet-providers.js"></script>

    <script src="leaflet/leaflet.markercluster.js"></script>

    <script src="https://npmcdn.com/leaflet-geometryutil"></script>

    <script src="Scripts/leaflet-ruler.js"></script>
    <style>
        #map {
            height: 100px;
        }
    </style>

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

    <!-- ======= Hero Section ======= -->
    <!--image: hero after-->
    <section id="hero" class="d-flex justify-cntent-center align-items-center">
        <div id="heroCarousel" class="container carousel carousel-fade" data-ride="carousel">

            <!-- Slide 1 -->
            <div class="carousel-item active">
                <div class="carousel-container">
                    <h2 class="animated fadeInDown">Welcome to <span>Koala Go</span></h2>
                    <p class="animated fadeInUp">
                        This website is dedicated to protecting koalas in the East Australia, focusing on New South Wales and Queensland. Let's get a volunteering opportunity to help Koalas.
                    </p>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <div class="carousel-container">
                    <h2 class="animated fadeInDown">Volunteering</h2>
                    <p class="animated fadeInUp">
                        This feature will bring you a variety of volunteering opportunities to support Koalas and assist you to choose the one best suited to your skills!
                    </p>
                    <a href="Volunteering.aspx" class="btn-get-started animated fadeInUp">Read More</a>
                </div>
            </div>

            <div class="carousel-item">
                <div class="carousel-container">
                    <h2 class="animated fadeInDown">Information</h2>
                    <p class="animated fadeInUp">This feature mainly provides some information about koalas and fires</p>
                    <a href="Information.aspx" class="btn-get-started animated fadeInUp">Read More</a>
                </div>
            </div>

            <!-- Slide 3 -->
            <div class="carousel-item">
                <div class="carousel-container">
                    <h2 class="animated fadeInDown">Koala Eye</h2>
                    <p class="animated fadeInUp">This feature will provide the latest koala sightings and rescue organizations in your vicinity based on your location and the distance you choose</p>
                    <a href="Map.aspx" class="btn-get-started animated fadeInUp">Read More</a>
                </div>
            </div>

            <a class="carousel-control-prev" href="#heroCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon bx bx-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>

            <a class="carousel-control-next" href="#heroCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon bx bx-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </section>
    <!-- End Hero -->

    <div style="text-align: center">
        <a href="#main">
            <img src="assets/img/icon/downward.png" height="40" width="40"></a>
    </div>

    <main id="main">
        <!-- End Services Section -->

        <!-- ======= Why Us Section ======= -->
        <div class=" mv" style="width: 100%;">

            <div class="row" style="width: 100%;" data-aos="fade-up" date-aos-delay="200">
                <div class="col-lg-6 video-box" style="height: 100%;">
                    <img src="assets/img/img-home2.jpg" class="img-fluid" alt="">
                </div>
                <div class="col-lg-6  justify-content-center " style="width: 100%;">
                    <div class="icon-box">
                        <h4 class="title">What we can do for them
                        </h4>
                        <p class="description">
                            <p>Unless you have received training or have relevant experience, you can only choose to find relevant volunteer companies and find volunteer services you are interested in to help the koala. such as:</p>

                            <p>Rescuing: Analyze whether the koala is in the environment by the forest fire, and rescue the koala in the potentially affected area.                                                                                     </p>

                            <p>Caring for koalas: Comes into contact with koalas from a distance, including daily observation, feeding, etc.                                                                                                            </p>

                            <p>Habitat maintenance: Mainly to carry out daily maintenance of the koala's habitat, or plant a tree for their home.                                                                                                       </p>

                            <p>Education: Inspiring more compassionate people to participate in the protection of koala families by sharing relevant knowledge about koalas.                                                                            </p>
                            <p>
                                Donation: Donation is also a fast way when you really want to make a contribution through your own efforts but can't spare your free time.
                            </p>

                            <p>For more information,  please click <a href="./Volunteering.aspx">here </a>
                                <p />
                            </p>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!--vedio part-->
        <section class="why-us section-bg" data-aos="fade-up" date-aos-delay="200">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 d-flex flex-column justify-content-center p-5">
                        <div class="icon-box">
                            <h4 class="title">Koala and Climate change</h4>
                            <br>
                            <p>Natural response of Koalas for small scrub fires is climbing higher up a eucalyptus tree, which protects them from short-lived low intensity fires. But the story differs in the case of intense crowning fires, which travels up to the top of the trees. Trapped Koalas on trees are surrounded by high intensity fire blazes, which leads to the loss of their lives from burning or smoke inhalation.</p>
                            <a href="https://www.telegraph.co.uk/news/2020/01/05/thousands-koalas-burn-death-australia-fears-native-wildlife/">Other Materials</a>
                        </div>
                    </div>
                    <div class="col-lg-6 video-box">
                        <img src="assets/img/img-info5.jpg" class="img-fluid" alt="">
                        <a href="https://www.youtube.com/watch?v=yQNUU-o1y2s" class="venobox play-btn mb-4" data-vbtype="video" data-autoplay="true"></a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12 d-flex flex-column justify-content-center p-5">
                        <p class="description">
                            “ Koalas are also at risk of dying from infections associated with these injuries, or from the ongoing effects of smoke inhalation. The fires in Australia’s southeast destroyed huge swathes of koala habitat in areas where they were already vulnerable - dehydrated and malnourished due to prolonged drought, climate change and land-clearing. “
              <a href="https://theconversation.com/scientists-find-burnt-starving-koalas-weeks-after-the-bushfires-133519">- The Conversation Media Group Ltd </a>
                        </p>
                        <p class="description">
                            “Most of the injuries to the koalas were caused by direct heat and smoke inhalation. This year, partly due to bushfires, there has been a 22 per cent increase, with koalas experiencing injuries such as singed foot pads or breathing problems due to smoke inhalation.”
              <a href="https://www.abc.net.au/news/2019-11-26/koala-population-at-tipping-point-after-australian-bushfires/11726232?nw=0">- ABC News (27th November 2019) </a>
                        </p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ======= Features Section ======= -->
        <section class="features">
            <div class="container">

                <div class="row" data-aos="fade-up">
                    <div class="col-md-5">
                        <img src="assets/img/img-home3.jpg" class="img-fluid" alt="">
                    </div>
                    <div class="col-md-7 pt-4">
                        <h3>Koalas are uniquely in Australia</h3>
                        <br>
                        <p>
                            The koala is an arboreal herbivorous marsupial native to Australia.
                        </p>
                        <p>It is the only extant representative of the family Phascolarctos and its closest living relatives are the wombats, which comprise the family Vombatidae.</p>
                        <p>The koala is found in coastal areas of the mainland's eastern and southern regions, inhabiting Queensland, New South Wales.</p>
                    </div>
                </div>

                <div class="row" data-aos="fade-up">
                    <div class="col-md-5 order-1 order-md-2">
                        <img src="assets/img/img-home4.png" class="img-fluid" alt="">
                    </div>
                    <div class="col-md-7 order-2 order-md-1">
                        <h3>Bushfire hits Australia</h3>
                        <br>
                        <p>
                            he pervasive smoke haunting our towns and cities, the red skies turning black, the thunderous raw and thick smoke that accompanied the wall of flames and the utter devastation."
                        </p>
                        <p>
                            In addition to the loss of life, more than 10 million hectares were burned across Australia during the 2019-20 bushfire season, destroying 3,000 homes and 7,000 outbuildings. Millions of native plants and animals and 80,000 livestock died.
                        </p>
                        <p>The harrowing experiences of this bushfire season will long linger in Australian national psyche.</p>
                    </div>
                </div>
            </div>
        </section>
        <!-- End Features Section -->
    </main><!-- End #main -->
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
            url: "index.aspx/getKoalaInfo",
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