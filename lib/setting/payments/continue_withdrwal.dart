import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/setting/payments/successful.dart';
import 'package:pro_trade/setting/profile.dart';

class Withdrawl2 extends ConsumerWidget {
 Withdrawl2({super.key});

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
            double h=MediaQuery.of(context).size.height;
            double w = MediaQuery.of(context).size.width;
            return Scaffold(
              backgroundColor: Color(0xff111111),
              appBar: AppBar(
                backgroundColor: Color(0xff111111),
                title: Text("Confirm Withdrawl",style: TextStyle(color: Colors.white),),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$ ${user.balance}",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white),),
                          Text("\$ ${user.balance-we}",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.white),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0,right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Balance",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.white),),
                          Text("After Withdrawl",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.white),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ase(100),
                        ase(200),
                        ase(500),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ase(1000),
                        ase(2000),
                        ase(5000),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0,bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: w/2-39,height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.shade900,
                            ),
                          ),
                          Text(
                            "   OR   ",
                            style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w800, fontSize: 13),
                          ),
                          Container(
                            width: w/2-39,height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.grey.shade900,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(" Choose Amount to Withdrawl",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
                    Container(
                      width:MediaQuery.of(context).size.width-40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w800
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          prefixText: "    ",
                          hintText: "    Enter Amount",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (String str){
                          we=double.parse(_controller.text);
                        },
                        onSubmitted: (String str){
                          we=double.parse(_controller.text);
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(" Overview",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
                    Container(
                      width: w-20,
                      decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Total Withdrawn",style: TextStyle(color: Colors.white),),
                                Spacer(),
                                Text("\$ ${we.toStringAsFixed(2)}",style: TextStyle(color: Colors.yellowAccent),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total Deduction",style: TextStyle(color: Colors.white),),
                                Spacer(),
                                Text("\$ ${(we*3/100).toStringAsFixed(2)}",style: TextStyle(color: Colors.yellowAccent),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total GST",style: TextStyle(color: Colors.white),),
                                Spacer(),
                                Text("\$ ${(we*18/100).toStringAsFixed(2)}",style: TextStyle(color: Colors.yellowAccent),),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Text("Withdrawable",style: TextStyle(color: Colors.white),),
                                Spacer(),
                                Text("\$ ${(we - (we*3/100)-(we*18/100)).toStringAsFixed(2)}",style: TextStyle(color: Colors.yellowAccent,fontWeight: FontWeight.w700),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              persistentFooterButtons: [
                InkWell(
                    onTap: () async {
                      if((user.balance-we).isNegative){
                        Global.showMessage(context, "Not Enough Balance", false);
                        return ;
                      }
                      TransactionModel pay=TransactionModel(
                          answer: false, name: user.name, method: "Withdrawl Requested",
                          rupees: we, pay: false, status: "In Transit",
                          time: user.name, time2: user.uid, nameUid: user.position,
                          id: id, pic: user.school, transactionId: "PRO_TRADE_$id", coins: we.toInt()
                      );
                      await FirebaseFirestore.instance.collection("Transaction").doc(id).set(pay.toJson());
                      await FirebaseFirestore.instance.collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid).update({
                        "withdrawal":FieldValue.increment(we),
                        "balance":FieldValue.increment(-we)
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PurchaseSuccessful(sum: we,success: false,)));
                    },
                    child: Global.button("Confirm Withdrawl", MediaQuery.of(context).size.width, Colors.yellowAccent))
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text("Error: $error"),
        ),
      ),
    );

  }
  final String id=DateTime.now().microsecondsSinceEpoch.toString();

 TextEditingController _controller=TextEditingController();
 double we=100.0;
 Widget ase(double guve)=>InkWell(
   onTap: (){
       we=guve;
       _controller.text=guve.toString();

   },
   child: Container(
     width: 100,
     color:we==guve? Colors.yellowAccent:Colors.white,
     child: Padding(
       padding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7),
       child: Center(child: Text(" \$ "+guve.toString(),style: TextStyle(color:we==guve?Colors.black: Colors.blue,fontSize: 18),)),
     ),
   ),
 );
}
