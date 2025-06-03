import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/admin/pages/all.dart';
import 'package:pro_trade/admin/pages/all_users.dart';
import 'package:pro_trade/admin/pages/portfolio.dart';
import 'package:pro_trade/admin/transaction_card.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/model/usermodel.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  TextEditingController text=TextEditingController();

  List<TransactionModel> list = [];

  late Map<String, dynamic> userMap;

  TextEditingController ud = TextEditingController();

  final Fire = FirebaseFirestore.instance;

  int paidcount=0;
  Future<void> countDocumentsInUsersINR() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users').where("balance",isGreaterThanOrEqualTo: 1)
          .get();
      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Users" collection: $docCount');
      setState(() {
        paidcount=docCount;
      });
    } catch (e) {
      print('Error counting documents: $e');
    }
  }
  late List<String> images = [];
  void initState(){
    countDocumentsInUsers();
    countDocumentsInUsersINR();
    countPending();
    counTrans();
    countpay(true);
    countpay(false);
  }
  ///M-------------------------------------------------->
  Future<void> countDocumentsInUsers() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();
      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Users" collection: $docCount');
      setState(() {
        totaluser=docCount;
      });
    } catch (e) {
      print('Error counting documents: $e');
    }
  }
int countdraw=0;
  Future<void> countDocumentsInUsersmorethab() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users').where("balance",isGreaterThan: 0.0)
          .get();
      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Users" collection with +1000: $docCount');
      setState(() {
        countdraw=docCount;
      });
    } catch (e) {
      print('Error counting documents: $e');
    }
  }

  ///M-------------------------------------------------->
  int totaltrans=0;
  Future<void> counTrans() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Transaction').get();
      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Users" collection: $docCount');
      setState(() {
        totaltrans=docCount;
      });
    } catch (e) {
      print('Error counting documents: $e');
    }
  }


  int totalpending=0;
  Future<void> countPending() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Transaction').where("answer",isEqualTo: false).get();
      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Users" collection: $docCount');
      setState(() {
        totalpending=docCount;
      });
    } catch (e) {
      print('Error counting documents: $e');
    }
  }
  Future<void> countpay(bool ogn) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Transaction')
          .where("pay",isEqualTo: ogn).where("status",isEqualTo: "Payment Proceed")
          .get();

      double totalAmount = 0.0;

      for (var doc in querySnapshot.docs) {
        final amount = doc['rupees']; // Accessing the amount field
        if (amount is double) {
          totalAmount += amount;
        }
      }

      final int docCount = querySnapshot.docs.length;
      print('Number of documents in "Transactions" collection: $docCount');
      print('Total amount: $totalAmount');

      setState(() {
        if(ogn){
          incoming = totalAmount; // Update the total amount (Add a variable in your state)
        }else{
          outgoing = totalAmount; // Update the total amount (Add a variable in your state)
        }

      });
    } catch (e) {
      print('Error counting documents or summing amount: $e');
    }
  }
  double outgoing=0.0;
  double incoming=0.0;

  DateTime uno=DateTime.now();

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text("Admin Panel",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: Total(all: true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("Today Incoming",w,Colors.yellow.shade400,incoming.toInt())),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: Total(all: false), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("Total Outgoing",w,Colors.blueAccent.shade100,outgoing.toInt())),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: UsersAll(all: false), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("Paid Users",w,Colors.green.shade300,paidcount)),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: AllPayments(all: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("All Payments",w,Colors.yellow.shade400,totaltrans)),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: AllPayments(all: false), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("Pending Payment",w,Colors.blueAccent.shade100,totalpending)),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: UsersAll(all: true), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: srr("All Users",w,Colors.green.shade300,totaluser)),
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 4,right: 15.0),
              child: Row(
                children: [
                  SizedBox(width: 6,),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context, PageTransition(
                          child: AllPayments(all: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                      ));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(child: Icon(Icons.calendar_month,color: Colors.black,),),
                        ),
                      ),
                    ),
                  ), SizedBox(width: 5,),
                  Text("Today's Transaction",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
                  Spacer(),
                  SizedBox(width: 7,),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: AllPayments(all: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                        ));
                      },
                      child: Text("See All Transaction",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.blue),)),
                  InkWell(
                      onTap: (){
                        Navigator.push(
                            context, PageTransition(
                            child: AllPayments(all: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                        ));
                      },
                      child: Icon(Icons.arrow_forward_outlined,color: Colors.blue,)),
                  SizedBox(width: 10,),
                ],
              ),
            ),
            Container(
              width: w,
              height: 550,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Transaction').where("answer",isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No data available for today',style: TextStyle(color: Colors.white)));
                      }
                      final data = snapshot.data!.docs.toList();
                      if (data.isEmpty) {
                        return Center(child: Text('No data available for today',style: TextStyle(color: Colors.white),));
                      }
                      final list = data.map((e) => TransactionModel.fromJson(e.data())).toList();
                      return ListView.builder(
                        itemCount: list.length,
                        padding: EdgeInsets.only(top: 10),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionCard(user: list[index],);
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  int todaytotal=0,tomorrowquiz=0,totaluser=0;
  Widget sr(String str,double w,Color color,int i,int j){
    return Container(
      width:w/3-10 ,
      height: 80,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 10),),
          Text("$i / $j",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 16),),
        ],
      ),
    );
  }
  Widget srr(String str,double w,Color color,int i){
    return Container(
      width:w/3-10 ,
      height: 80,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 10),),
          Text("$i",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 16),),
        ],
      ),
    );
  }
}
