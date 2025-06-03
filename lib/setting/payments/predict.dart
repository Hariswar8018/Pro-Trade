import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';

class Predict extends StatefulWidget {
  Predict({super.key, });

  static const List<double> featureMin = [3707.4, 3783.85, 3707, 4324200990];
  static const List<double> featureMax = [3947, 3947, 3935, 5244856836];
  static const targetMin = 3707.23;
  static const targetMax = 3947.98;

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  late final Interpreter _interpreter;


 void as()async{
   _interpreter = await Interpreter.fromAsset('assets/btc_price_predictor.tflite');
 }


  // Min and max values for normalization
  final List<double> featureMin = [0.0, 0.999, 0.999, 2.0e10]; // Adjust based on actual model normalization
  final List<double> featureMax = [1000.0, 1.001, 1.001, 6.0e10]; // Adjust based on actual model normalization
  final double targetMin = 0.999; // Example min for target
  final double targetMax = 1.001; // Example max for target

  double show = 0.0;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/btc_price_predictor.tflite');
  }

  // Normalize function
  List<double> _normalize(List<double> input, List<double> min, List<double> max) {
    return List.generate(input.length, (i) => (input[i] - min[i]) / (max[i] - min[i]));
  }

  // Denormalize function
  double _denormalize(double value, double min, double max) {
    return value * (max - min) + min;
  }

  // Predict function
  double predict(double daysSinceReference, double high, double low, double volume) {
    // Normalize input
    final input = _normalize([daysSinceReference, high, low, volume], featureMin, featureMax);

    // Prepare input tensor
    final inputTensor = [input];

    // Prepare output tensor
    final outputTensor = List.filled(1, 0.0).reshape([1, 1]);

    // Run inference
    _interpreter.run(inputTensor, outputTensor);

    // Denormalize output
    return _denormalize(outputTensor[0][0], targetMin, targetMax);
  }

  void nowpred() {
    // Generate example date and convert to numeric format
    DateTime referenceDate = DateTime(2023, 1, 1);
    DateTime futureDate = DateTime.now().add(Duration(days: (30 * yearstime).toInt())); // Adjust '30 * 12' for your use case
    double daysSinceReference = futureDate.difference(referenceDate).inDays.toDouble();

    // Example feature values for high, low, and volume
    double high = 1.0002;    // Example high value
    double low = 0.9998;     // Example low value
    double volume = 3.0e10;  // Example volume value

    // Predict price
    double predictedPrice = predict(daysSinceReference, high, low, volume);

    // Print and display the result
    print("Predicted BTC Close Price: $predictedPrice");
    setState(() {
      show = predictedPrice;
    });
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }


  double years=100.0;
  Widget year(double w, double given){
    return InkWell(
      onTap: (){
        nowpred();
        setState(() {
          years=given;
        });
      },
      child: Container(
        width: w/3-15,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            color: years!=given?Colors.yellowAccent:Colors.black
          ),
            color: years==given?Colors.yellowAccent:Colors.black
        ),
        child: Center(
          child: Text(given.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w900,color:years==given?Colors.black: Colors.yellowAccent),)
        ),
      ),
    );
  }

  double yearstime=3.0;
  Widget yeartime(double w, double given){
    return InkWell(
      onTap: (){
        nowpred();
        setState(() {
          yearstime=given;
        });
      },
      child: Container(
        width: w/3-15,
        height: 45,
        decoration: BoxDecoration(
            border: Border.all(
                color: yearstime!=given?Colors.yellowAccent:Colors.black
            ),
            color: yearstime==given?Colors.yellowAccent:Colors.black
        ),
        child: Center(
            child: Text(given.toStringAsFixed(0),style: TextStyle(fontWeight: FontWeight.w900,color:yearstime==given?Colors.black: Colors.yellowAccent),)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        backgroundColor: Color(0xff000000),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          "Predict", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/predict.webp",width: w,),
            ),
            s("If you would have Invested"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                year(w, 100.0),
                year(w, 200.0),
                year(w, 500.0),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                year(w, 1000.0),
                year(w, 2000.0),
                year(w, 5000.0),
              ],
            ),
            SizedBox(height: 5,),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                year(w, 10000.0),
                year(w, 20000.0),
                year(w, 50000.0),
              ],
            ),
            SizedBox(height: 5,),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                year(w, 100000.0),
                year(w, 200000.0),
                year(w, 500000.0),
              ],
            ),
            SizedBox(height: 14,),
            s(yearstime>=13?"for ${(yearstime/12).toStringAsFixed(0)} Year":"for ${(yearstime).toStringAsFixed(0)} Months"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yeartime(w, 3.0),
                yeartime(w, 6.0),
                yeartime(w, 12.0),
              ],
            ),SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                yeartime(w, 24.0),
                yeartime(w, 60.0),
                yeartime(w, 120.0),
              ],
            ),
            SizedBox(height: 20,),
            s("You would have get Profit of : "),
            SizedBox(height: 3,),
            Center(
              child: Container(
                width: w-20,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(7)
                ),
                child: Center(
                  child: Text("${((show*years+(0.1*(show*years))+(0.302*yearstime))).toStringAsFixed(2)}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  Widget s(String str){
   return Padding(
     padding: const EdgeInsets.all(11.0),
     child: Text(str,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 19,color: Colors.white),),
   );
  }
}
