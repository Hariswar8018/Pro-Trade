import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_trade/home/home.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/provider/declare.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title="jbhj"});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState(){
    fy();
  }
  Future<void> fy() async {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    bool away= await asyncPrefs.getBool('night')??false;
    if(gh!=null){
      setState(() {

      });
    }
  }

  String gh=FirebaseAuth.instance.currentUser!.email!;
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Center(child: Text("0")),
    Center(child: Text("1")),
    Center(child: Text("2")),
    Center(child: Text("3")),
    Center(child: Text("4"))
  ];

  Widget diu(){
    return Text("");
  }
  Future<bool> _onWillPop(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure you want to exit?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Stay in the app
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Exit the app
              child: Text("Exit"),
            ),
          ],
        );
      },
    ) ?? false; // If the dialog is dismissed, return false (stay in the app)
    return exitApp;
  }

  final userProvider = AsyncNotifierProvider<UserController, UserModel?>(() {
    return UserController();
  });
  void dr(WidgetRef ref) async {
    await ref.read(userProvider.notifier).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: sd(false));
  }

  Widget sd(bool b){
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body:Home(),
    );
  }
  int _currentIndex = 0;
}