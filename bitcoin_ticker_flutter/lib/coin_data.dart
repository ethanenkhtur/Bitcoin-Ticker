import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const apiKey = 'D1F796E6-2E98-4CA9-9554-7118F6EBDAB7';
const coinAPIUrl = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  dynamic exRateData;

  Future<Map<String, String>> getExchangeData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String cryptoName in cryptoList) {
      String requestURL =
          '$coinAPIUrl/$cryptoName/$selectedCurrency/?apiKey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        dynamic decodedData = jsonDecode(response.body);
        double theRate = decodedData['rate'];
        cryptoPrices[cryptoName] = theRate.toStringAsFixed(1);
      } else {
        if (kDebugMode) {
          print('Error status code: ${response.statusCode}');
        }
        throw ('Problem with the get request');
      }
    }
    return cryptoPrices;
  }
  //   http.Response response = await http.get(
  //       Uri.parse('$coinAPIUrl/$theCryptoName/$theCurrency/?apiKey=$apiKey'));
  //
  //   if (response.statusCode == 200) {
  //     dynamic decodedData = jsonDecode(response.body);
  //     double theRate = decodedData['rate'];
  //     exRateData = theRate.toStringAsFixed(1);
  //     return exRateData;
  //   } else {
  //     if (kDebugMode) {
  //       print('Error, status code: ${response.statusCode}');
  //     }
  //     throw 'Problem with the get request.';
  //   }
  // }
}
