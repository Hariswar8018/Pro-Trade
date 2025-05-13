import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/login/affiliate_links.dart';



class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: Colors.blue,
        // backgroundProvider: NetworkImage('https://picsum.photos/720/1280'),
        skipCallback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AffiliateLinks()));
        },
        finishCallback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AffiliateLinks()));
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color:const Color(0xFF536DFE),
        imageAssetPath: 'assets/IMG_2618-removebg-preview.png',
        title: 'Earn USDT like Crazy',
        body: 'Maximize your digital asset returns with Pro Trade',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF0D1015),
        imageAssetPath: 'assets/IMG_2614.JPG',
        title: 'Growing Investment',
        body: 'Our Client got stable growth since 4 years',
        doAnimateImage: true),
    PageModel(
        color:  Colors.orange.shade500,
        imageAssetPath: 'assets/IMG_2611-removebg-preview.png',
        title: 'Withdrawl within 24 - 48 Hours',
        body: 'You can start with just 100\$',
        doAnimateImage: true),
  ];
}
