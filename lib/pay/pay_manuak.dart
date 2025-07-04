import 'dart:convert';
import 'dart:typed_data';

import 'package:binance_pay/binance_pay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/model/transaction.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/provider/storage.dart';
import 'package:pro_trade/setting/payments/successful.dart';
import 'package:pro_trade/pay/update.dart';

class PayManuak extends StatefulWidget {
  UserModel user;
  PayManuak({super.key,required this.user});

  @override
  State<PayManuak> createState() => _PayManuakState();
}

class _PayManuakState extends State<PayManuak> {

  late double usdtprice;
  void initState(){
    yes();
    Update().updateUSDT();
  }
  void yes() async{
    try {
      print("Start");
      var value = await fetchUSDTValue('price'); // replace 'price' with your key
      usdtprice=value;
      setState(() {

      });
    } catch (e) {
      print('Error: $e');
    }
  }


  Future<double> fetchUSDTValue(String key) async {
    final DocumentReference usdtDoc = FirebaseFirestore.instance.collection('USDTData').doc("USDT");
    try {
      DocumentSnapshot snapshot = await usdtDoc.get();
      if (snapshot.exists) {
        // Get all data as a map
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey(key)) {
          return data[key];
        } else {
          print("No Key");
          return 0.0;
        }
      } else {
        print("No Data");
        return 0.0;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return 0.0;
      rethrow;
    }
  }
  bool isyes=true;
  bool open=false;
  bool open1=true;
  int calculateDifferenceInMinutes(String isoDateString) {
    try {
      final DateTime firestoreDateTime = DateTime.now();

      // Parse ISO8601 date string to DateTime
      final DateTime isoDateTime = DateTime.parse(isoDateString);

      // Calculate the difference in minutes
      final int differenceInMinutes = firestoreDateTime
          .difference(isoDateTime)
          .inMinutes
          .abs();

      return differenceInMinutes;
    }catch(e){
      return -1;
    }
  }
  Widget a(String str1, String str2,final data){
    return  Row(
      children: [
        Text("$str1 : ",style: TextStyle(color: Colors.grey),),
        Text("\$${(data['$str2'] as double).toStringAsFixed(2)}",style: TextStyle(fontSize: 17,color: gy(data['$str2'] as double),fontWeight: FontWeight.w800),),
        r(data['$str2'] as double),
      ],
    );
  }
  Widget r(double t){
    if(t.isNegative){
      return Icon(Icons.arrow_drop_down,color: gy(t),size: 15,);
    }
    return Icon(Icons.arrow_drop_up,color: gy(t),size: 15,);
  }

  Color gy(double t){
    if(t.isNegative){
      return Colors.red;
    }
    return Colors.greenAccent;
  }
  Future<bool> _onWillPop(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit Investment"),
          content: Text("Are you sure you want not to Invest Now?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Stay in the app
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Exit the app
              child: Text("Exit"),
            ),
          ],
        );
      },
    ) ?? false; // If the dialog is dismissed, return false (stay in the app)
    return exitApp;
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Color(0xff111111),
        appBar: AppBar(
          backgroundColor: Color(0xff111111),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text("Invest Now",style: TextStyle(color: Colors.white),),
        ),
        body:isyes? Padding(
          padding: const EdgeInsets.only(left: 17.0,right: 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Invest",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              Text("Current showing Price will be Locked In",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
              SizedBox(height: 10,),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('USDTData').doc('USDT').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    print("Error: ${snapshot.error}");
                    return Text("Error: ${snapshot.error}");
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    print("No data available");
                    return Text("No data available");
                  }

                  // Log the received data
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  print("Firestore Data: $data");

                  if (data == null) {
                    return Text("Data is null");
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/coin.png",height: 40,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "   USDT",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900,color: Colors.white),
                                  ),
                                  Text("    Tether USDt",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.grey),),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  decoration: BoxDecoration(
                                      color:Colors.grey,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7.0,right: 7,top:3,bottom:3),
                                    child: Text("Updated "+calculateDifferenceInMinutes(data['last_updated']).toString()+" min ago",style: TextStyle(color: Colors.white,fontSize: 8),),
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Price: ",style: TextStyle(color: Colors.grey),),
                              Text("\$${(data['price'] as double).toStringAsFixed(4)}",style: TextStyle(fontSize: 17,color: gy(data['price'] as double),fontWeight: FontWeight.w800),),
                            ],
                          ),
                          a("Market Cap", "market_cap", data),
                          a("Volume Change", "volume_change_24h", data),
                          a("1h Change", "percent_change_1h", data),
                          a("24h Change", "percent_change_24h", data),
                          a("7d Change", "percent_change_7d", data),
                          SizedBox(height: 10,),
                          InkWell(
                            onTap: (){
                              setState(() {
                                open=!open;
                              });
                            },
                            child: Row(
                              children: [
                                Text(open?"Show Less  ":"Show More  ",style: TextStyle(color: Colors.grey),),
                                open?Icon(Icons.arrow_drop_up,color: Colors.grey,):Icon(Icons.arrow_drop_down,color: Colors.grey,)
                              ],
                            ),
                          ),
                          open?a("30d Change", "percent_change_30d", data):SizedBox(),
                          open?a("60d Change", "percent_change_60d", data):SizedBox(),
                          open?a("Total Supply", "total_supply", data):SizedBox(),
                          open?a("Circulation Supply", "circulating_supply", data):SizedBox(),
                          open?a( "Market Dominance", "market_cap_dominance",data):SizedBox(),

                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: Container(
                      width: w-40,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          // specify the radius for the top-left corner
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          // specify the radius for the top-right corner
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          f(w, 0),
                          f(w, 1),
                        ],
                      )
                  ),
                ),
              ),
              Text(review==0?"Select USDT Amount":"Select INR Amount",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white),),
              Text("Select the Price to Invest with Us",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
              SizedBox(height: 10,),
              review==0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ase(100),
                  ase(200),
                  ase(500),
                ],
              ): Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ase(9000),
                  ase(20000),
                  ase(30000),
                ],
              ),
              SizedBox(height: 10,),
              review==0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ase(1000),
                  ase(2000),
                  ase(5000),
                ],
              ) : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ase(40000),
                  ase(50000),
                  ase(100000),
                ],
              ),
              SizedBox(height: 5,),
              review==0?SizedBox():Text("Total USDT receive : ${((usdtprice/85.06) *we ).toStringAsFixed(2)}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.white),),
              SizedBox(height: 5,),
              InkWell(
                onTap: (){
                  setState(() {
                    isyes=!isyes;
                  });
                },
                child: Center(
                  child: Container(
                      width: w - 35,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color(0xffA0D8F1),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child:  Center(
                        child: Text(
                          "Manual Pay",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ):SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    open1=true;
                  });
                },
                child: Center(
                  child:open1? Stack(
                    children: [
                      Container(
                        width: w-40,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: AssetImage(review==0?"assets/scanner.png":"assets/upi.jpg"),fit: BoxFit.contain)
                        ),
                      ),
                      Container(
                          width: w-40,
                            height: 50,
                            decoration: BoxDecoration(
                      color: Color(0xffA0D8F1),
                      borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pay by QR Scan ( Manual ) "),
                        Icon(Icons.arrow_drop_down),
                      ],
                                  ),
                            ),
                          ),
                    ],
                  ):Container(
                    width: w-40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Global.blac,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pay by QR Scan ( Manual ) "),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text("Once Payment Done ! Upload and Paste Transaction ID",style: TextStyle(color: Colors.white),),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        try {
                          Uint8List? _file = await pickImage(
                              ImageSource.gallery);
                          String photoUrl = await StorageMethods()
                              .uploadImageToStorage('users', _file!, true);
                          photo=photoUrl;
                          setState(() {

                          });
                          Global.showMessage(context, "Uploaded",true);
                        }catch(e){
                          Global.showMessage(context, "$e",false);
                        }
                      },
                      child: Container(
                        width: w/2-15,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xffA0D8F1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload,color: Colors.black,),
                              Text("Upload Screenshot",style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: w/2-45,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("  Waiting to Upload JPEG",style: TextStyle(fontSize: 8,color: Colors.white),)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Center(
                child: Container(
                  width: w - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Enter Transaction ID",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: () async {
                  if(controller.text.isEmpty){
                    Global.showMessage(context, "Transaction ID is atleast Required", false);
                    return ;
                  }
                  String id=DateTime.now().microsecondsSinceEpoch.toString();
                  TransactionModel pay=TransactionModel(
                      answer: false, name: widget.user.name, method: "Investment Requested",
                      rupees: review==0?we:((usdtprice/85.06) *we ), pay: true, status: "In Transit",
                      time: widget.user.name, time2: widget.user.uid, nameUid: widget.user.pic,
                      id: id, pic: photo, transactionId: controller.text, coins: review==0?we.toInt():((usdtprice/85.06) *we ).toInt()
                  );
                  await FirebaseFirestore.instance.collection("Transaction").doc(id).set(pay.toJson());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PurchaseSuccessful(sum: we,success:true,)));

                },
                child: Center(
                  child: Container(
                    width: w-40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xffA0D8F1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Yes, Complete Payment ",style: TextStyle(color: Colors.black),),
                          Icon(Icons.credit_card_outlined,color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String photo="";
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  TextEditingController controller=TextEditingController();
  makePayment() async {
    BinancePay pay = BinancePay(
      apiKey: "PagYVegHzhTw4PddPzotwUMMglmNk3wg5ZzKJ8UIvsJlrjl4nBuM5IIXIY7lgsxe",
      apiSecretKey: "0pVjBppJ3v668syBQc4QHgMcpQ5v07wDej0SySBtFfgpJVCld2ZYbGhxnkI59KpS",
    );
print(pay.toString());
    String tradeNo = generateMerchantTradeNo();

    print(tradeNo);
    OrderResponse response = await pay.createOrder(
      body: RequestBody(
        merchantTradeNo: tradeNo,
        orderAmount: we.toString(),
        currency: 'BUSD',
        goodsType: '01',
        goodsCategory: '1000',
        referenceGoodsId: DateTime.now().microsecondsSinceEpoch.toString(),
        goodsName: 'PRO_TRADE_INVEST',
        goodsDetail: 'Investment for Pro Trade',
      ),
    );
// Log the response for debugging.
    debugPrint('Response: ${response.errorMessage}');
   print(response.status);
    QueryResponse queryResponse = await pay.queryOrder(
      merchantTradeNo: tradeNo,
      prepayId: response.data!.prepayId,
    );

    debugPrint(queryResponse.status);

    CloseResponse closeResponse = await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    debugPrint(closeResponse.status);
  }
  int review=0;
  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/2-40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yes==review?Color(0xffA0D8F1):Global.blac,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            yes==0?Text("\$",style: TextStyle(color: yes==review? Colors.black:Colors.white,fontWeight: FontWeight.w900),):Text(""),
             SizedBox(width: 3,),
            Text(yiop(yes),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:yes==review? Colors.black:Colors.white)),
          ],
        ),
      ),
    ),
  );
  String yiop(int y){
    if(y==0){
      return "USD";
    }else if(y==1){
      return "INR";
    }else {
      return "Invites";
    }
  }
  double we=100.0;
  Widget ase(double guve)=>InkWell(
    onTap: (){
      setState(() {
        we=guve;
      });
    },
    child: Container(
      width: 100,
      height: 40,
      color:we==guve? Color(0xffA0D8F1):Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 7,bottom: 7),
        child: Center(child: Text(review==0?" \$ "+guve.toString():" ₹ "+guve.toString(),style: TextStyle(color:we==guve?Colors.black: Colors.blue,fontSize: 13),)),
      ),
    ),
  );
}
