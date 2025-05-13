import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/model/usermodel.dart';

class History extends StatelessWidget {
  UserModel user;
  History({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      appBar: AppBar(
        backgroundColor: Color(0xff111111),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          "Transaction History", style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Transaction').where("time2",isEqualTo: user.uid).snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No History found.',style: TextStyle(color: Colors.white),));
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
}
