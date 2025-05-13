import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/settings.dart';
import 'package:pro_trade/home/stless.dart';
import 'package:pro_trade/main.dart';
import 'package:pro_trade/model/usdt.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/pay/pay_manuak.dart';
import 'package:pro_trade/setting/portfolio.dart';
import 'package:pro_trade/usdt_card/usdy+card.dart';

class Home extends StatefulWidget {
   Home({super.key,required this.user});
final UserModel user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      drawer: Global.drawer(context,widget.user),
      backgroundColor: Color(0xff111111),
      appBar: AppBar(
        backgroundColor: Color(0xff111111),
        leading: InkWell(
          onTap:(){
            scaffoldKey.currentState?.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/logo.jpg"),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: Portfolio(user: widget.user), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
              ));
            },
            child: CircleAvatar(
              backgroundColor: Color(0xff111111),
              child: Center(child: Icon(Icons.account_balance_wallet,color: Colors.white,)),
            ),
          ),  SizedBox(width: 3,),
          InkWell(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: Settingss(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
              ));
            },
            child: CircleAvatar(
              backgroundColor: Color(0xff111111),
              child: Center(child: Icon(Icons.person,color: Colors.white,)),
            ),
          ),  SizedBox(width: 3,),
          InkWell(
            onTap:(){
              scaffoldKey.currentState?.openDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Color(0xff111111),
              child: Center(child: Icon(Icons.more_vert,color: Colors.white,)),
            ),
          ),
          SizedBox(width: 1,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Easy 3 Step Investing",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w800,color: Colors.white),),
              SizedBox(height: 9,),
          
              Container(
                width: w-30,height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 13,),
              FlutterCarousel(
                options: FlutterCarouselOptions(
                  height: 130,
                  viewportFraction: 1,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(),
                ),
                items: [0,1,2].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: w,
                        height: 130,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w/4.5,
                              height: w/4.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.white
                                  )
                              ),
                              child: Center(
                                child: Text((i+1).toString(),style: TextStyle(
                                    fontSize: 29,fontWeight: FontWeight.w500,color: Colors.white
                                ),),
                              ),
                            ),
                            SizedBox(width: 14,),
                            Container(
                              width: w-(w/4)-35,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(str(i),style: TextStyle(color: Color(0xffABC07D),fontWeight: FontWeight.w600),),
                                  SizedBox(height: 9,),
                                  Text(str1(i),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text("Total USDT Value",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                  SizedBox(width: 4,),
                  InkWell(
                      onTap: (){

                      },
                      child: Icon(Icons.remove_red_eye,color: Colors.white,)),
                ],
              ),
              Row(
                children: [
                  Text("${widget.user.balance} usdt ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.white),),
                  SizedBox(width: 4,),

                ],
              ),
              SizedBox(height: 19),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$ ${widget.user.balance}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.white),),
                  Container(
                    width:2,height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Rewards",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                      Text("${widget.user.rewards} USDT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    ],
                  ),
                  Container(
                    width:2,height: 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Exp. Rewards",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                      Text("${widget.user.expectedRewards} USDT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 19),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: PayManuak(user: widget.user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: Center(
                  child: Container(
                      width: w - 35,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child:  Center(
                        child: Text(
                          "Invest More",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 19),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('USDTData').doc('USDT').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
          
                if (snapshot.hasError) {
                  print("Error: ${snapshot.error}");
                  return Text("Error: ${snapshot.error}");
                }
          
                if (!snapshot.hasData || snapshot.data == null) {
                  print("No data available");
                  return Text("No data available");
                }
          
                // Log the received data
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                print("Firestore Data: $data");
          
                if (data == null) {
                  return Text("Data is null");
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/coin.png",height: 40,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "   USDT",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900,color: Colors.white),
                                ),
                                Text("    Tether USDt",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.grey),),
                              ],
                            ),
                            Spacer(),
                            Container(
                                decoration: BoxDecoration(
                                  color:Colors.grey,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7.0,right: 7,top:3,bottom:3),
                                  child: Text("Updated "+calculateDifferenceInMinutes(data['last_updated']).toString()+" min ago",style: TextStyle(color: Colors.white,fontSize: 8),),
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Price: ",style: TextStyle(color: Colors.grey),),
                            Text("\$${(data['price'] as double).toStringAsFixed(4)}",style: TextStyle(fontSize: 17,color: gy(data['price'] as double),fontWeight: FontWeight.w800),),
                          ],
                        ),
                        a("Market Cap", "market_cap", data),
                        a("Volume Change", "volume_change_24h", data),
                        a("1h Change", "percent_change_1h", data),
                        a("24h Change", "percent_change_24h", data),
                        a("7d Change", "percent_change_7d", data),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              open=!open;
                            });
                          },
                          child: Row(
                            children: [
                              Text(open?"Show Less  ":"Show More  ",style: TextStyle(color: Colors.grey),),
                              open?Icon(Icons.arrow_drop_up,color: Colors.grey,):Icon(Icons.arrow_drop_down,color: Colors.grey,)
                            ],
                          ),
                        ),
                        open?a("30d Change", "percent_change_30d", data):SizedBox(),
                        open?a("60d Change", "percent_change_60d", data):SizedBox(),
                        open?a("Total Supply", "total_supply", data):SizedBox(),
                        open?a("Circulation Supply", "circulating_supply", data):SizedBox(),
                        open?a( "Market Dominance", "market_cap_dominance",data):SizedBox(),

                      ],
                    ),
                  ),
                );
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
  bool open=false;
  int calculateDifferenceInMinutes(String isoDateString) {
    try {
      final DateTime firestoreDateTime = DateTime.now();

      // Parse ISO8601 date string to DateTime
      final DateTime isoDateTime = DateTime.parse(isoDateString);

      // Calculate the difference in minutes
      final int differenceInMinutes = firestoreDateTime
          .difference(isoDateTime)
          .inMinutes
          .abs();

      return differenceInMinutes;
    }catch(e){
      return -1;
    }
  }
  Widget a(String str1, String str2,final data){
    return  Row(
      children: [
        Text("$str1 : ",style: TextStyle(color: Colors.grey),),
        Text("\$${(data['$str2'] as double).toStringAsFixed(2)}",style: TextStyle(fontSize: 17,color: gy(data['$str2'] as double),fontWeight: FontWeight.w800),),
        r(data['$str2'] as double),
      ],
    );
  }
  Widget r(double t){
    if(t.isNegative){
      return Icon(Icons.arrow_drop_down,color: gy(t),size: 15,);
    }
    return Icon(Icons.arrow_drop_up,color: gy(t),size: 15,);
  }
  
  Color gy(double t){
    if(t.isNegative){
      return Colors.red;
    }
    return Colors.greenAccent;
  }
  
  Widget c(int y)=>Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: 7,height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: y==0?Colors.white:Colors.grey
      ),
    ),
  );

  String str(int i){
    if(i==0){
      return "Choose USDT as a Former Investment for your Portfolio Journey with us";
    }else if(i==1){
      return "Pay USDT by Scanning QR Code and Invest";
    }
    return "That's All ! You will Receive Periodic Investment Cash";
  }
  String str1(int i){
    if(i==0){
      return "USDT is Dominating Bitcoin in World, and Fluctuation are shown every Minute";
    }else if(i==1){
      return "After Paying, We disclose all your Portfolio into a Single Public Portfolio";
    }
    return "Portfolio are Updated Every Week, with Withdrawl every 24 Hours";
  }
}

