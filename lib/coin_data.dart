import 'dart:convert';
import 'package:http/http.dart' as http;

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData() async {
    http.Response response = await http.get(
      Uri.parse(bitcoinUrl),
    );
    if (response.statusCode == 200) {
      var data = response.body;
      var rate = jsonDecode(data)["rate"];

      return rate;
    } else {
      print(response.statusCode);
      throw "Could not establis connection";
    }
  }
}

const bitcoinUrl =
    "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=DEC3C8C2-EACC-4139-A140-44D09C9C3A66";
