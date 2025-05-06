import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/login/login.dart';


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
                  builder: (context) => Login()));
        },
        finishCallback: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login()));
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color:const Color(0xFF536DFE),
        imageAssetPath: 'assets/coin.png',
        title: 'Earn USDT like Crazy',
        body: 'Our Trading Platform help Invest USDT for Futurw',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF111111),
        imageAssetPath: 'assets/invest.webp',
        title: 'Growing Investment',
        body: 'Our Clients got Stable Growth since 20 Years',
        doAnimateImage: true),
    PageModel(
        color:  Colors.orange.shade500,
        imageAssetPath: 'assets/pngtree-illustration-of-men-using-atm-machines-to-save-money-png-image_6838481.png',
        title: 'Withdrawl within 24 Hours',
        body: 'Withdrawl Take Less 30% Less time than other Vendoes',
        doAnimateImage: true),
  ];
}
