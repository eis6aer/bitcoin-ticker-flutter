
import 'dart:convert';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/mappers/exchange_rate.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://rest.coinapi.io/v1";
const apiKey = "";

class GetExchangeRate {
  Future<Map<String, String>> invoke(String currency) async {

    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      var response = await http.get("$baseUrl/exchangerate/$crypto/$currency?apikey=$apiKey");
      if (response.statusCode == 200) {
        cryptoPrices[crypto] = ExchangeRate.fromJson(jsonDecode(response.body)).rate.toStringAsFixed(2);
      } else {
        cryptoPrices[crypto] = '?';
      }
    }

    return cryptoPrices;
  }
}