import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/pay/pay_manuak.dart';
import 'package:pro_trade/setting/history.dart';
import 'package:pro_trade/setting/portfolio.dart';

import '../global.dart';

class Userdetail extends StatelessWidget {
  UserModel user;
  Userdetail({super.key,required this.user});

  bool  isDarkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Center(
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
                  ),
                  Spacer(),
                  Text(user.balance.toString(),style: TextStyle(fontWeight: FontWeight.w800),),
                  SizedBox(width: 20,)
                ],
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
                        child: History(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: c(w, "History", Icon(Icons.history,color: !isDarkModeEnabled?  Colors.white:Colors.black), "0")),
              InkWell(
                  onTap: () async {
                    Navigator.push(
                        context, PageTransition(
                        child: Portfolio(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: c(w, "Total Invested", Icon(Icons.outbond_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black,), user.deposit.toStringAsFixed(2))),
              InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: Portfolio(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: c(w, "Total Returns", Icon(Icons.call_received_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black), user.withdrawal.toStringAsFixed(2))),
            ],
          ),
          SizedBox(height: 10,),
        ],
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
}
