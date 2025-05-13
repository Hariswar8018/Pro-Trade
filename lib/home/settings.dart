
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/login/login.dart';
import 'package:pro_trade/login/onbairdinf.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/pay/pay_manuak.dart';
import 'package:pro_trade/setting/about_update.dart';
import 'package:pro_trade/setting/history.dart';
import 'package:pro_trade/setting/invite.dart';
import 'package:pro_trade/setting/portfolio.dart';
import 'package:pro_trade/setting/profile.dart';
import 'package:pro_trade/setting/payments/withdrawl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../provider/declare.dart';

class Settingss extends ConsumerWidget {
  bool isDarkModeEnabled =false;

  final userControllerProvider = AsyncNotifierProvider<UserController, UserModel?>(() => UserController());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider); // Update to your provider name
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: Center(
        child: userState.when(
          data: (user) {
            if (user == null) {
              return const Text("No user data available");
            }
            return Scaffold(
              backgroundColor: Color(0xff111111),
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                title: Text("Settings",style: TextStyle(color: Colors.white),),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: Profile(user: user, update: true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      },
                      child: Center(
                        child: Container(
                          width: w-30,
                          decoration: BoxDecoration(
                              color:!isDarkModeEnabled? Global.blac:Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black,width: 0.3
                              )
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(user.pic),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.name,style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white,fontSize: 20,fontWeight: FontWeight.w700),),
                                  Text(user.email,style: TextStyle(color: isDarkModeEnabled?Colors.black:Colors.white,fontSize: 12,fontWeight: FontWeight.w400),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, PageTransition(
                                  child: PayManuak(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                              ));
                            },
                            child: c(w, "Pay Now", Icon(Icons.credit_score,color: !isDarkModeEnabled?  Colors.white:Colors.black,), "No")),
                        InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, PageTransition(
                                  child: History(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                              ));
                            },
                            child: c(w, "History", Icon(Icons.history,color: !isDarkModeEnabled?  Colors.white:Colors.black), "0")),
                        InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, PageTransition(
                                  child: Withdrawl(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                              ));
                            },
                            child: c(w, "Withdrawl", Icon(Icons.account_balance,color: !isDarkModeEnabled?  Colors.white:Colors.black), "0")),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context, PageTransition(
                                  child: Portfolio(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                              ));
                            },
                            child: c2(w, "Total Invested", Icon(Icons.outbond_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black,), user.deposit.toStringAsFixed(2))),
                        InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, PageTransition(
                                  child: Portfolio(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                              ));
                            },
                            child: c2(w, "Total Returns", Icon(Icons.call_received_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black), user.withdrawal.toStringAsFixed(2))),
                      ],
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: Profile(user: user, update: true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                        ));
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color:isDarkModeEnabled?Colors.white: Global.blac,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              ),
                              border: Border.all(
                                  color: Colors.black,width: 0.3
                              )
                          ),
                          width: w-20,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                Icon(Icons.person,color:isDarkModeEnabled?Colors.black: Colors.white),
                                SizedBox(width: 7,),
                                Text("User Profile",style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          Navigator.push(
                              context, PageTransition(
                              child: AboutAndMissionScreen(adbout: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                          ));
                        },
                        child: r(w,"About Us", Icon(Icons.info,color:isDarkModeEnabled?Colors.black: Colors.white),)),
                    InkWell(
                        onTap: () async {
                          Navigator.push(
                              context, PageTransition(
                              child: AboutAndMissionScreen(adbout: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                          ));
                        },
                        child: r(w,"Our Mission", Icon(Icons.remove_red_eye,color:isDarkModeEnabled?Colors.black: Colors.white),)),

                    InkWell(
                        onTap: () async {
                          Navigator.push(
                              context, PageTransition(
                              child: ReferralScreen(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                          ));
                        },
                        child: r(w,"Refer & Earn", Icon(Icons.share,color:isDarkModeEnabled?Colors.black: Colors.white),)),
                    InkWell(
                        onTap: () async {
                          final Uri _url = Uri.parse('https://evergreenwealth.in/');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: r(w,"Website", Icon(Icons.language,color: isDarkModeEnabled?Colors.black:Colors.white),)),
                    InkWell(
                        onTap: () async {
                          final Uri _url = Uri.parse('https://evergreenwealth.in/contact-us/');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: r(w,"Contact Us", Icon(Icons.support_agent_outlined,color: isDarkModeEnabled?Colors.black:Colors.white),)),
                    InkWell(
                        onTap: () async {
                          try{
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.sendPasswordResetEmail(email: FirebaseAuth.instance.currentUser!.email!);
                            Global.showMessage(context, "Reset Email Sended",true);
                          }catch(e){
                            Global.showMessage(context, "$e",false);
                          }
                        },
                        child: r(w,"ResetPassword", Icon(Icons.lock_reset,color: isDarkModeEnabled?Colors.black:Colors.white),)),
                    InkWell(
                      onTap: (){
                        FirebaseAuth auth = FirebaseAuth.instance;
                        auth.signOut().then((res) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>OnboardingPage(title: '',)),
                          );
                        });
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color:isDarkModeEnabled?Colors.white: Global.blac,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              border: Border.all(
                                  color: Colors.black,width: 0.3
                              )
                          ),
                          width: w-20,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                Icon(Icons.login,color: Colors.red),
                                SizedBox(width: 7,),
                                Text("Log Out",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60,),
                  ],
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text("Error: $error"),
        ),
      ),
    );

  }
  Widget c(double w,String s,Widget r,String g){
    return Container(
      width: w/3-20,
      height: w/3-40,
      decoration: BoxDecoration(
          color:!isDarkModeEnabled? Global.blac:Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black,width: 0.4)
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            r,
            Text(s,style: TextStyle(color:!isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 12),),
          ],
        ),
      ),
    );
  }

  Widget c2(double w,String s,Widget r,String g){
    return Container(
      width: w/2-20,
      height: w/3-40,
      decoration: BoxDecoration(
          color: !isDarkModeEnabled? Global.blac:Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black,width: 0.4)
      ),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            r,
            Text(s,style: TextStyle(color:  !isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 8),),
            Spacer(),
            Text("\$ "+g,style: TextStyle(color:  !isDarkModeEnabled?  Colors.white:Colors.black,fontSize: 18),),
          ],
        ),
      ),
    );
  }
  Widget r1(double w, String str,Widget r,Widget r1)=>Center(
    child: Container(
      decoration: BoxDecoration(
        color: isDarkModeEnabled?Colors.white:Global.blac,
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),),
            Spacer(),
            r1,
          ],
        ),
      ),
    ),
  );

  Widget r(double w, String str,Widget r)=>Center(
    child: Container(
      decoration: BoxDecoration(
          color: isDarkModeEnabled?Colors.white:Global.blac,
          border: Border.all(
              color: Colors.black,width: 0.3
          )
      ),
      width: w-20,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            r,
            SizedBox(width: 7,),
            Text(str,style: TextStyle(color:isDarkModeEnabled?Colors.black: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    ),
  );
}
