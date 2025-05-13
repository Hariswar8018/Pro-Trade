import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/setting/payments/continue_withdrwal.dart';
import 'package:pro_trade/setting/profile.dart';

class Withdrawl extends ConsumerWidget {
  const Withdrawl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider); // Up
    return Scaffold(
      body: Center(
        child: userState.when(
          data: (user) {
            if (user == null) {
              return const Text("No user data available");
            }
            return Scaffold(
              backgroundColor: Color(0xff111111),
              appBar: AppBar(
                backgroundColor: Color(0xff111111),
                title: Text("Withdrawl",style: TextStyle(color: Colors.white),),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Binance ID",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                    Text("12DF3698R4",style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.w900),),
                    SizedBox(height: 20,),
                    Text("My Name",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                    Text(user.name,style: TextStyle(fontSize: 21,color: Colors.white,fontWeight: FontWeight.w900),),
                    SizedBox(height: 20,),
                    Text("My QR",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w400),),
                    SizedBox(height: 3,),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width-40,
                          height: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: user.school.isEmpty?AssetImage("assets/gn.gif"):NetworkImage(user.school),fit: BoxFit.contain)
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width-40,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xffABC07D),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(user.school.isEmpty?"Error ! Upload QR for Binance":"My QR Code ( Preffered ) "),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              persistentFooterButtons: [
                Column(
                  children: [
                    InkWell(
                        onTap: (){
                          /*if(user.school.isEmpty||user.position.isEmpty||user.name.isEmpty){
                            Global.showMessage(context, "QR Code, Name, as well as Binance ID is Necessary", false);
                            return ;
                          }*/
                          Navigator.push(
                              context, PageTransition(
                              child: Withdrawl2(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                          ));
                        },
                        child: Global.button("Continue to Withdraw", MediaQuery.of(context).size.width, Colors.yellowAccent)),
                    SizedBox(height: 6,),
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context, PageTransition(
                              child: Profile(user: user, update: true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                          ));
                        },
                        child: Global.button("Update My Documents", MediaQuery.of(context).size.width, Colors.grey))
                  ],
                )
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text("Error: $error"),
        ),
      ),
    );

  }
}
