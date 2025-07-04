import 'package:flutter/material.dart';

class AboutAndMissionScreen extends StatelessWidget {
 AboutAndMissionScreen({super.key,required this.adbout});
bool adbout;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111), // Matches dark blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(adbout?"About Us":"Our Mission",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child:adbout?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("assets/logo.jpg",width: 100,),
            ),const SizedBox(height: 30),
            Center(
              child: const Text(
                "About Us",textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(textAlign: TextAlign.center,
              '''Welcome to pro trade, your trusted partner in the world of digital assets. with pro trade you can confidently grow your portfolio through innovative trading & investments solutions. transparent operations, and expert-driven strategies, ensuring your assets work harder for you.
              ''',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ): Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("assets/logo.jpg",width: 100,),
            ), const SizedBox(height: 30),
            Center(
              child: const Text(
                "Our Mission", textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              textAlign: TextAlign.center,
              "Our mission is to deliver sustainable and attractive returns to our users through innovative staking solutions. "
                  "By leveraging advanced trading strategies and comprehensive risk management, we strive to offer consistent and reliable monthly returns.",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
