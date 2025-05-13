import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/admin/transaction_card.dart';
import 'package:pro_trade/model/transaction.dart';

class AllPayments extends StatelessWidget {
  bool all;
  AllPayments({super.key,required this.all});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text(all?"All Payments":"Pending Payments",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: all?FirebaseFirestore.instance.collection('Transaction').snapshots():FirebaseFirestore.instance.collection('Transaction').where("answer",isEqualTo: false).snapshots(),
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
    );
  }
}
