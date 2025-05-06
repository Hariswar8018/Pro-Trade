import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/main.dart';
import 'package:pro_trade/pay/pay_manuak.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void startRepeatingFunction() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      // Your function logic here
      update();
    });
  }

  void update(){
    if(i>=2){
      setState(() {
       i=0;
      });
    }else{
      setState(() {
        i+=1;
      });
    }

  }
  void initState(){
    startRepeatingFunction();
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      appBar: AppBar(
        backgroundColor: Color(0xff111111),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/logo.jpg"),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Color(0xff111111),
            child: Center(child: Icon(Icons.person,color: Colors.white,)),
          ),  SizedBox(width: 3,),
          CircleAvatar(
            backgroundColor: Color(0xff111111),
            child: Center(child: Icon(Icons.more_vert,color: Colors.white,)),
          ),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: CircleAvatar(
              backgroundColor: Color(0xff111111),
              child: Center(child: Icon(Icons.login,color: Colors.red,)),
            ),
          ),
          SizedBox(width: 3,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15,top: 10),
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
            Container(
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
                        Text(str(),style: TextStyle(color: Color(0xffABC07D),fontWeight: FontWeight.w600),),
                        SizedBox(height: 9,),
                        Text(str1(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                c(0),
                c(1),
                c(2),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text("Total USDT Value",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                SizedBox(width: 4,),
                Icon(Icons.remove_red_eye,color: Colors.white,),
              ],
            ),
            Row(
              children: [
                Text("0.0 usdt ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.white),),
                SizedBox(width: 4,),
                Icon(Icons.arrow_drop_down_outlined,color: Colors.white,),
              ],
            ),
            SizedBox(height: 19),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$ 0.00",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.white),),
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
                    Text("0 USDT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
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
                    Text("0 USDT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                  ],
                ),
              ],
            ),
            SizedBox(height: 19),
            InkWell(
              onTap: (){
                Navigator.push(
                    context, PageTransition(
                    child: PayManuak(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
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
            )
          ],
        ),
      ),
    );
  }
  Widget c(int y)=>Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: 7,height: 7,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: y==i?Colors.white:Colors.grey
      ),
    ),
  );
  int i =0;
  String str(){
    if(i==0){
      return "Choose USDT as a Former Investment for your Portfolio Journey with us";
    }else if(i==1){
      return "Pay USDT by Scanning QR Code and Invest";
    }
    return "That's All ! You will Receive Periodic Investment Cash";
  }
  String str1(){
    if(i==0){
      return "USDT is Dominating Bitcoin in World, and Fluctuation are shown every Minute";
    }else if(i==1){
      return "After Paying, We disclose all your Portfolio into a Single Public Portfolio";
    }
    return "Portfolio are Updated Every Week, with Withdrawl every 24 Hours";
  }
}
