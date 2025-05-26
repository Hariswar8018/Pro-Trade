import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/admin/userdetail.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/model/usermodel.dart';

class TransactionCard extends StatelessWidget {

  TransactionModel user;
  TransactionCard({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return user.answer?answered(w,context):pending(w,context);
  }
  Widget pending(double w,BuildContext context){
   return InkWell(
     onTap: (){
       if(!user.pay){
         showModalBottomSheet(
           context: context,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
           ),
           backgroundColor: Colors.white,
           isScrollControlled: true,
           builder: (BuildContext context) {
             return Container(
               width: w,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   SizedBox(height: 20),
                   Text(
                     'Already Paid User ?',
                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                   ),
                   Text(
                     'Please Paste the Transaction ID of Payment to confirm ',
                     style: TextStyle(fontSize: 13,),
                   ),
                   SizedBox(height: 20),
                   SizedBox(height: 10),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextField(
                       controller: controller,
                       decoration: InputDecoration(
                         labelText: 'Please Type the Transaction ID',
                         border: OutlineInputBorder(),
                       ),
                     ),
                   ),
                   SizedBox(height: 10),
                   InkWell(
                     onTap: () async {
                       if(controller.text.isEmpty){
                         Navigator.pop(context);
                         Global.showMessage(context, "Error ! Transaction ID was Empty", false);
                       }else{
                         try {
                           await FirebaseFirestore.instance.collection('Transaction')
                               .doc(user.id)
                               .update({
                             "answer": true,
                             "status": "Payment Proceed",
                             "name":controller.text,
                           });
                           Navigator.pop(context);
                           Global.showMessage(context, "Done !", false);
                         }catch(e){
                           Navigator.pop(context);
                           Global.showMessage(context, "$e", false);
                         }
                       }
                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.lightGreenAccent,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.account_balance_wallet),
                               Text(
                                 "Confirm Payment Receipt and PAY",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 5),
                  InkWell(
                    onTap: () async {
                      finds(context, true);
                    },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.deepOrange,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.close),
                               Text(
                                 "Cancel & Refund",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 5),
                   InkWell(
                     onTap: () async {
                       showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(
                             title: Text("Alert"),
                             content: Text("Money will be Lost Forever"),
                             actions: [
                               TextButton(
                                 onPressed: () async {
                                   try {
                                     await FirebaseFirestore.instance.collection('Transaction')
                                         .doc(user.id)
                                         .update({
                                       "answer": true,
                                       "status": "Payment Cancelled",
                                     });
                                     Navigator.pop(context);
                                     Navigator.pop(context);
                                     Global.showMessage(context, "Done !", false);
                                   }catch(e){
                                     Navigator.pop(context);
                                     Navigator.pop(context);
                                     Global.showMessage(context, "$e", false);
                                   }
                                 },
                                 child: Text("Close"),
                               ),
                             ],
                           );
                         },
                       );

                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.warning),
                               Text(
                                 "Cancel & NO REFUND",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 5),
                   InkWell(
                     onTap: () async {
                       finds(context, false);
                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.blue,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.info),
                               Text(
                                 "More Information Needed & Refund",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 20),
                 ],
               ),
             );
           },
         );
       }else{
         showModalBottomSheet(
           context: context,
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
           ),
           backgroundColor: Colors.white,
           isScrollControlled: true,
           builder: (BuildContext context) {
             return Container(
               width: w,
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   SizedBox(height: 20),
                   Text(
                     'Had User Done Payment ?',
                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                   ),
                   Text(
                     'Select the Required field below to Confirm Transaction Process',
                     style: TextStyle(fontSize: 13,),
                   ),
                   SizedBox(height: 20),
                   InkWell(
                     onTap: (){
                       Navigator.pop(context);
                       find(context, true);
                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.lightGreenAccent,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.account_balance_wallet),
                               Text(
                                 "Confirm Payment Receipt and PAY",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 5),
                   InkWell(
                     onTap: () async {
                       try {
                         await FirebaseFirestore.instance.collection('Transaction')
                             .doc(user.id)
                             .update({
                           "answer": true,
                           "status": "Payment Cancelled",
                           "name":"Payment Cancelled",
                         });
                         Navigator.pop(context);
                         Global.showMessage(context, "Done !", false);
                       }catch(e){
                         Global.showMessage(context, "$e", false);
                       }
                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.red,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.close),
                               Text(
                                 "Cancel",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 5),
                   InkWell(
                     onTap: () async {
                       try {
                         await FirebaseFirestore.instance.collection('Transaction')
                             .doc(user.id)
                             .update({
                           "answer": true,
                           "status": "Payment Cancelled",
                           "name":"Payment Cancelled due to More Information Needed !",
                         });
                         Navigator.pop(context);
                         Global.showMessage(context, "Done !", false);
                       }catch(e){
                         Global.showMessage(context, "$e", false);
                       }
                     },
                     child: Center(
                       child: Container(
                           width: w - 35,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.blue,
                               borderRadius: BorderRadius.circular(6)
                           ),
                           child:  Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.info),
                               Text(
                                 "More Information Needed",
                                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                               ),
                             ],
                           )
                       ),
                     ),
                   ),
                   SizedBox(height: 20),
                 ],
               ),
             );
           },
         );
       }
     },
     onLongPress: () async {
       try {
         CollectionReference usersCollection = FirebaseFirestore
             .instance
             .collection('users');
         QuerySnapshot querySnapshot = await usersCollection.where(
             'uid', isEqualTo: user.time2).get();
         if (querySnapshot.docs.isNotEmpty) {
           UserModel userr = UserModel.fromSnap(
               querySnapshot.docs.first);
           Navigator.push(
               context, PageTransition(
               child: Userdetail(user: userr,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
           ));
         } else {
           Global.showMessage(context, "Couldn't find User", false);
         }
       }catch(e){
         Global.showMessage(context, "$e", false);
       }
     },
     child: Card(
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Container(
          width: w,
          child:Column(
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
              SizedBox(height: 12,),
              Text("      Transaction ID : ${user.transactionId}"),
              SizedBox(height: 12,)
            ],
          ),
        ),
      ),
   );
  }
  Future<void> finds(BuildContext context,bool accept) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore
          .instance
          .collection('users');
      QuerySnapshot querySnapshot = await usersCollection.where(
          'uid', isEqualTo: user.time2).get();
      if (querySnapshot.docs.isNotEmpty) {
        UserModel user = UserModel.fromSnap(
            querySnapshot.docs.first);
        Global.showMessage(context, "Affiliate Code Valid!", true);
        pays(context, user, accept);
      } else {
        Global.showMessage(context, "Couldn't find User", false);
      }
    }catch(e){
      Global.showMessage(context, "$e", false);
    }
  }

  void pays(BuildContext context,UserModel userr,bool accept){
    double w=MediaQuery.of(context).size.width;
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  'Confirm Refund?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Please Confirm by LONG PRESS on User',
                  style: TextStyle(fontSize: 13,),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: Userdetail(user: userr,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  },
                  child: Container(
                    width: w-40,
                    height: 90,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blue
                        ),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.pic),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text(userr.name,style: TextStyle(fontWeight: FontWeight.w800),),
                              Text(userr.email),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    try {
                      await FirebaseFirestore.instance.collection('Transaction')
                          .doc(user.id)
                          .update({
                        "answer": true,
                        "status": "Payment Refunded",
                        "name":accept?"Cancelled by Admin":"Cancelled due to Account Details Not Match"
                      });
                      await FirebaseFirestore.instance.collection("users").doc(
                          userr.uid).update({
                        "balance": FieldValue.increment(user.rupees),
                      });
                      Navigator.pop(context);
                      Global.showMessage(context, "Done !", false);
                    }catch(e){
                      Global.showMessage(context, "$e", false);
                    }
                  },
                  child: Center(
                    child: Container(
                        width: w - 35,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet),
                            Text(
                              "Yes, Confirm",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      );
  }

  TextEditingController controller=TextEditingController();

  Future<void> find(BuildContext context,bool accept) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore
          .instance
          .collection('users');
      QuerySnapshot querySnapshot = await usersCollection.where(
          'uid', isEqualTo: user.time2).get();
      if (querySnapshot.docs.isNotEmpty) {
        UserModel user = UserModel.fromSnap(
            querySnapshot.docs.first);
        Global.showMessage(context, "Affiliate Code Valid!", true);
        pay(context, user, accept);
      } else {
        Global.showMessage(context, "Couldn't find User", false);
      }
    }catch(e){
      Global.showMessage(context, "$e", false);
    }
  }

  void pay(BuildContext context,UserModel userr,bool accept){
    double w=MediaQuery.of(context).size.width;
    if(accept){
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            width: w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  'Confirm ?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Please Confirm by LONG PRESS on User',
                  style: TextStyle(fontSize: 13,),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context, PageTransition(
                        child: Userdetail(user: userr,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));

                  },
                  child: Container(
                    width: w-40,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue
                      ),
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.pic),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text(userr.name,style: TextStyle(fontWeight: FontWeight.w800),),
                              Text(userr.email),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () async {
                    try {
                      await FirebaseFirestore.instance.collection('Transaction')
                          .doc(user.id)
                          .update({
                        "answer": true,
                        "status": "Payment Proceed",
                      });
                      await FirebaseFirestore.instance.collection("users").doc(
                          userr.uid).update({
                        "balance": FieldValue.increment(user.rupees),
                        "deposit": FieldValue.increment(user.rupees),
                      });
                      df(userr.afflink);
                      Navigator.pop(context);
                      Global.showMessage(context, "Done !", false);
                    }catch(e){
                      Global.showMessage(context, "$e", false);
                    }
                  },
                  child: Center(
                    child: Container(
                        width: w - 35,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet),
                            Text(
                              "Yes, Confirm",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    }
  }

  Widget answered(double w,BuildContext context){
    return InkWell(
      onLongPress: () async {
        try {
          CollectionReference usersCollection = FirebaseFirestore
              .instance
              .collection('users');
          QuerySnapshot querySnapshot = await usersCollection.where(
              'uid', isEqualTo: user.time2).get();
          if (querySnapshot.docs.isNotEmpty) {
            UserModel userr = UserModel.fromSnap(
                querySnapshot.docs.first);
            Navigator.push(
                context, PageTransition(
                child: Userdetail(user: userr,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
            ));
          } else {
            Global.showMessage(context, "Couldn't find User", false);
          }
        }catch(e){
          Global.showMessage(context, "$e", false);
        }
      },
      child: Card(
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Container(
          width: w,
          child:ListTile(
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

  Future<void> df(String userids) async {
    try{
      print("done------------------------------------------------------------------>");
      double referamount=0.06*user.rupees ;
      CollectionReference usersCollection = FirebaseFirestore
          .instance
          .collection('users');
      await usersCollection.doc(userids).update({
        "affearn":FieldValue.increment(referamount),
        "balance":FieldValue.increment(referamount),
      });
      print("done");
    }catch(e){
      print(e);
    }
  }
}
