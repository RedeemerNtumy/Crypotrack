import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'USD',
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
  'AUD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData(this.currency);
  String currency;
  Future getCoinData() async {
    http.Response response = await http.get(
      Uri.parse(bitcoinUrl+"$currency"+apiKey),
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

const bitcoinUrl = "https://rest.coinapi.io/v1/exchangerate/BTC/";
const apiKey = "?apikey=DEC3C8C2-EACC-4139-A140-44D09C9C3A66";
