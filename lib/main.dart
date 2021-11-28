import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomepage());
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  late BannerAd? _bannerAds;

  void _createBannerAds() {
    _bannerAds = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(onAdLoaded: (Ad ad) {
        print("Ad loaded");
      }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
        print("Ad failed");
        ad.dispose();
      }, onAdOpened: (Ad ad) {
        print("Ad loaded");
      }),
      request: const AdRequest(),
    );
  }

  @override
  void initState() {
    _createBannerAds();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Ads App"),
      ),
      body: const Center(
        child: Text("Demo Ads App"),
      ),
      bottomNavigationBar: _bannerAds == null
          ? const SizedBox.shrink()
          : SizedBox(
              height: _bannerAds?.size.height.toDouble(),
              width: _bannerAds?.size.width.toDouble(),
              child: AdWidget(ad: _bannerAds!..load()),
            ),
    );
  }
}
