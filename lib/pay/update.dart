import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_trade/model/usdt.dart';
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Update{
  Future<USDTModel?> fetchUSDTData(String apiKey) async {
    const String url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest";
    final Map<String, String> headers = {
      "X-CMC_PRO_API_KEY": apiKey,
      "Accept": "application/json",
    };

    final Uri uri = Uri.parse(url).replace(queryParameters: {
      "symbol": "USDT",
      "convert": "USD",
    });

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return USDTModel.fromJson(jsonData['data']['USDT']);
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  Future<void> fetchAndSaveUSDT(String apiKey) async {
    final CollectionReference usdtCollection =
    FirebaseFirestore.instance.collection('USDTData');
    final DocumentReference usdtDoc = usdtCollection.doc("USDT");

    try {
      // Fetch the last saved document
      final DocumentSnapshot snapshot = await usdtDoc.get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final Timestamp lastUpdated = data['lastUpdated'];
        final DateTime lastUpdatedTime = lastUpdated.toDate();
        final DateTime currentTime = DateTime.now();

        if (currentTime.difference(lastUpdatedTime).inMinutes < 10) {
          print("Using cached data. No API call made.");
          return ;
        }
      }
      final usdtData = await fetchUSDTData(apiKey);

      if (usdtData != null) {
        await usdtDoc.set({
          ...usdtData.toMap(),
          'lastUpdated': Timestamp.now(), // Save the current timestamp
        });
        print("USDT data saved successfully!");
      } else {
        print("Failed to fetch USDT data.");
      }
    } catch (e) {
      print("Error fetching and saving USDT data: $e");
    }
  }

  final String apiKey="12158163-ea12-4417-8c46-6e866e7654e8";


  void updateUSDT() async {
    await fetchAndSaveUSDT(apiKey);
  }


}