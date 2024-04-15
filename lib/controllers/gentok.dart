import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class GenTokController extends GetxController {
  var paytoken = ''.obs;
  var token = ''.obs;
  var errorMessage = ''.obs;
  var paymentResponse = ''.obs;
  Future<String> fetchToken() async {
    final String apiUrl = 'https://api.orange.com/oauth/v3/token';

    final Map<String, String> headers = {
      'Authorization':
          'Basic QXU1M3JLeEhSMzRsckNyT251emNDV0RrQVExQXVBdmw6WDJsdTJYYVNhWkhJOUczVw==',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      "Access-Control_Allow_Origin": "*"
    };

    final Map<String, String> body = {
      'grant_type': 'client_credentials',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        token.value = data['access_token'];
        errorMessage.value = '';
        print(data['access_token']);
        //await makeWebPayment();
        return data['access_token'];
      } else {
        errorMessage.value = 'Failed to fetch token';
        print(errorMessage.value);
        return errorMessage.value;
      }
    } catch (error) {
      errorMessage.value = 'Error fetching token: $error';
      print(errorMessage.value);
      return errorMessage.value;
    }
  }

  Future<void> makeWebPayment(String token,int amount) async {
    final String apiUrl = 'https://api.orange.com/orange-money-webpay/dev/v1/webpayment';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final String randomOrderId = 'MY_ORDER_ID_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999999)}';

    final Map<String, dynamic> body = {
      "merchant_key": "a7cca573",
      "currency": "OUV",
      "order_id": randomOrderId,
      "amount": 1200,
      "return_url": "http://myvirtualshop.webnode.es",
      "cancel_url": "http://myvirtualshop.webnode.es/txncncld/",
      "notif_url": "http://www.merchant-example2.org/notif",
      "lang": "fr",
      "reference": "ref Merchant"
    };

    final http.Client client = http.Client();

    try {
      final response = await client
          .post(
            Uri.parse(apiUrl),
            headers: headers,
            body: json.encode(body),
          )
          .timeout(Duration(seconds: 30)); // Increased timeout to 30 seconds

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        paymentResponse.value = json.encode(data);
        print(paymentResponse.value);
        await launchUrl(Uri(scheme:'https',host:'mpayment.orange-money.com',path: data['payment_url'].toString().split('https://mpayment.orange-money.com/')[1]));
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to make web payment';
        print(errorMessage.value);
      }
    } catch (error) {
      errorMessage.value = 'Error making web payment: $error';
      print(errorMessage.value);
    } finally {
      client.close(); // Close the client
      print(errorMessage.value);
    }
  }
}
