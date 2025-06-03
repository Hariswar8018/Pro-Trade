import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/setting/history.dart';

class Portfolio extends StatefulWidget {
 Portfolio({super.key,required this.user});

 UserModel user;

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool isDarkModeEnabled =false;

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      appBar: AppBar(
        title: Text("My Portfoilio",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff111111),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
          children: [
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
            SizedBox(height: 30),
            Text("Other Account Info",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
            SizedBox(height: 3),
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
                    Text("Returns",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                    Text("${widget.user.expectedRewards} USDT",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
                  ],
                ),
              ],
            ),
            SizedBox(height:30,),
            Text("Summary",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
            SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(

                    child: c2(w, "Total Invested", Icon(Icons.outbond_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black,), widget.user.deposit.toStringAsFixed(2))),
                InkWell(

                    child: c2(w, "Total Returns", Icon(Icons.call_received_rounded,color: !isDarkModeEnabled?  Colors.white:Colors.black), widget.user.withdrawal.toStringAsFixed(2))),
              ],
            ),
            SizedBox(height: 20,),

            Row(
              children: [
                Text("Recent Transactions",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
                Spacer(),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: History(user: widget.user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                    },
                    child: Text("See All >   ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.yellowAccent),)),
              ],
            ),
            SizedBox(height: 3),
            Container(
              width: w,
              height: 300,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Transaction').where("time2",isEqualTo: widget.user.uid).snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No users found.'));
                      }
                      final users = snapshot.data!.docs.map((doc) {
                        return TransactionModel.fromJson(
                            doc.data() as Map<String, dynamic>);
                      }).toList();
                      return ListView.builder(
                        itemCount: users.length,
                        padding: const EdgeInsets.only(bottom: 3.0),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return Card(
                            elevation: 4,
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: w,
                              child:user.answer? ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: user.pay ? Icon(
                                    Icons.outbond_rounded, color: Colors.white,) : Icon(
                                    Icons.call_missed_outgoing, color: Colors.white,),
                                ),
                                title: Text(
                                  !user.pay ? "Debit" : "Credit", style: TextStyle(
                                    fontWeight: FontWeight.w800),),
                                subtitle: Text(formatDateTime(user.id)),
                                trailing: Text("\$" + user.rupees.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800, fontSize: 19),),
                              ):
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: user.pay ? Icon(
                                        Icons.outbond_rounded, color: Colors.white,) : Icon(
                                        Icons.call_missed_outgoing, color: Colors.white,),
                                    ),
                                    title: Text(
                                      !user.pay ? "Debit" : "Credit", style: TextStyle(
                                        fontWeight: FontWeight.w800),),
                                    subtitle: Text(formatDateTime(user.id)),
                                    trailing: Text("\$" + user.rupees.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800, fontSize: 19),),
                                  ),
                                  Text("      Waiting for Admin Verification....."),
                                  SizedBox(height: 12,)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  String formatDateTime(String dateTimeString) {
    try {
      // Parse the input string into a DateTime object
      final DateTime parsedDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(dateTimeString));

      // Format the DateTime object to "DD/MM/YY on HH:MM"
      final String formattedDate = DateFormat('dd/MM/yy').format(parsedDate);
      final String formattedTime = DateFormat('HH:mm').format(parsedDate);

      return '$formattedDate on $formattedTime';
    } catch (e) {
      // Handle parsing errors
      return 'Invalid DateTime format';
    }
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
}
