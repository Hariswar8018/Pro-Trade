

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_trade/admin/navigation.dart';
import 'package:pro_trade/home/home.dart';
import 'package:pro_trade/model/usdt.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/pay/update.dart';
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
    Update().updateUSDT();
  }
  final userControllerProvider = AsyncNotifierProvider<UserController, UserModel?>(() => UserController());
  String gh=FirebaseAuth.instance.currentUser!.email!;
  int _selectedIndex = 0;

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

  bool admin= FirebaseAuth.instance.currentUser!.email=="mohansir.ik70@gmail.com"||FirebaseAuth.instance.currentUser!.email=="i@g.com";

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.email);
    double w=MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: sd(admin)
    );
  }

  Widget sd(bool b){
    if(b){
      return AdminNavigation();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Consumer(
        builder: (context, ref, child) {
          final userState = ref.watch(userControllerProvider);
          return userState.when(
            data: (user) => user == null
                ? const Center(child: Text('No user data available'))
                : Home(user: user,),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        },
      ),
    );
  }
  int _currentIndex = 0;
}
final userControllerProvider = AsyncNotifierProvider<UserController, UserModel?>(() => UserController());
