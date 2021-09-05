import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> getDropDownAndroid() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String coin in currenciesList) {
      var dropDown = DropdownMenuItem(
        child: Text(coin),
        value: coin,
      );
      dropDownItems.add(dropDown);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          getRate();
          selectedCurrency = value.toString();
          print(selectedCurrency);
          updateCurrency(selectedCurrency, amount);
        });
      },
    );
  }

  CupertinoPicker pickerApple() {
    List<Text> items = [];
    for (String item in currenciesList) {
      items.add(Text(item));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          getRate();
          selectedCurrency = items[selectedIndex].data.toString();
          print(selectedCurrency);
          updateCurrency(selectedCurrency, amount);
        });
      },
      children: items,
    );
  }

  String selectedCurrency = "USD";
  String amount = "0";
  String currency = "USD";

  void updateCurrency(String money, String coin) {
    currency = money;
    amount = coin;
  }

  void getRate() async {
    try {
      double exchangeRate = await CoinData(currency).getCoinData();
      setState(() {
        amount = exchangeRate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Cryptotrack'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  "1 BTC= $amount $currency",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? pickerApple() : getDropDownAndroid()),
        ],
      ),
    );
  }
}
