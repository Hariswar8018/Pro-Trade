import 'package:cloud_firestore/cloud_firestore.dart';
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
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: AddMoney(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
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
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text("PAY USER Returns"),
                  trailing: Icon(Icons.arrow_forward_outlined),
                )
              ),
            ),
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

class AddMoney extends StatelessWidget {
  UserModel user;
   AddMoney({super.key,required this.user});
  final _emailController = TextEditingController();
  bool  isDarkModeEnabled = true;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:Text("Send Money",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),  backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body:Column(
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
          SizedBox(height : 15),
          Center(child: Text("Send Return of Payment", style: TextStyle( color : Colors.white,fontFamily: "font1", fontSize: 30, fontWeight: FontWeight.w700))),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("You Promised 6% return now is Time to give back what Promised", style: TextStyle( color : Colors.white,fontFamily: "font1", fontSize: 17, fontWeight: FontWeight.w400), textAlign: TextAlign.center,)),
          ),
          SizedBox(height : 6),
          Image.asset("assets/IMG_2611-removebg-preview.png", height : 200),
          SizedBox(height : 5),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.number,
              style: TextStyle(color:Colors.white),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/coin.png",width: 5,),
                ),
                labelText: 'USDT Coin',  isDense: true,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your School email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () async {
                if(_emailController.text.isEmpty){
                  Global.showMessage(context, "Amount Can\'t be left Empty",false);
                }else{
                  try {
                    double news=double.parse(_emailController.text);
                    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
                      "expectedRewards":FieldValue.increment(news),
                      "balance":FieldValue.increment(news),
                    });
                    Navigator.pop(context);
                    Global.showMessage(context, "Done ! Sent Successful......Updating in few minutes", true);
                  }catch(e){
                    Global.showMessage(context, "$e", false);
                  }
                }
              },
              child:Center(
                child: Container(
                    width: w - 35,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child:  Center(
                      child: Text(
                        "PAY",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
