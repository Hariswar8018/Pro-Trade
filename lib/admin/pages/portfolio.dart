import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/admin/transaction_card.dart';
import 'package:pro_trade/model/transaction.dart';

class Total extends StatefulWidget {
  bool all;
  Total({super.key,required this.all});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  void initState(){
    countpay(true);
    countpay(false);
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
        title: Text(on?"Incoming Portfolio":"OutGoing Portfolio",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              color: Colors.white,
              child: Container(
                width: w-20,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Total Portfolio Balance",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),)
                        ],
                      ),
                      SizedBox(height: 1,),
                      Row(
                        children: [
                          Image.asset("assets/coin.png",height: 30,),
                          Text("  "+incoming.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),)
                        ],
                      ),
                      Spacer(),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Incoming Balance",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                          Text("Outgoing Balance",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                        ],
                      ),
                      SizedBox(height: 1,),
                      Row(
                        children: [
                          Icon(Icons.call_missed_outlined,color: Colors.blue,),
                          Text("  "+incoming.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),),
                          Spacer(),

                          Text("  "+outgoing.toString(),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22),),
                          Icon(Icons.outbond_rounded,color: Colors.red,),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              given(on, w, "Incoming"),
              given(!on, w, "Outgoing"),
            ],
          ),
          SizedBox(height: 10,),
          Container(
            width: w,
            height: h-400,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Transaction').where("status",isEqualTo: "Payment Proceed").where("pay",isEqualTo: on).snapshots(),
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
          )
        ],
      ),
    );
  }
  bool on=true;
  Widget given(bool f,double w,String str){
    return InkWell(
      onTap: (){
        on=!on;
        setState(() {

        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,style: TextStyle(color:f? Colors.white:Colors.grey),),
          SizedBox(height: 3),
          Container(
            width: w/2-20,
            height: 5,
            decoration: BoxDecoration(
                color:f? Colors.white:Colors.grey,
                borderRadius: BorderRadius.circular(50)
            ),
          ),
        ],
      ),
    );
  }
}
