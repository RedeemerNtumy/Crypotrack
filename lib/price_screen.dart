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

          if (selectedCurrency == 'BTC') {
            updateCurrencyBtc(selectedCurrency, amountBtc);
          } else if (selectedCurrency == 'ETH') {
            updateCurrencyEth(selectedCurrency, amountEth);
          } else {
            updateCurrencyLtc(selectedCurrency, amountLtc);
          }
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

          if (selectedCurrency == 'BTC') {
            updateCurrencyBtc(selectedCurrency, amountBtc);
          } else if (selectedCurrency == 'ETH') {
            updateCurrencyEth(selectedCurrency, amountEth);
          } else {
            updateCurrencyLtc(selectedCurrency, amountLtc);
          }
        });
      },
      children: items,
    );
  }

  String selectedCurrency = "USD";
  String amountBtc = "0";
  String amountEth = "0";
  String amountLtc = "0";
  String currency = "USD";

  void updateCurrencyBtc(String money, String coin) {
    currency = money;
    amountBtc = coin;
  }
  void updateCurrencyEth(String money, String coin) {
    currency = money;
    amountEth = coin;
  }
   void updateCurrencyLtc(String money, String coin) {
    currency = money;
    amountLtc = coin;
  }
  void getRate() async {
    try {
      double exchangeRateBtc = await CoinData('BTC', currency).getCoinData();
      setState(() {
        amountBtc = exchangeRateBtc.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
    try {
      double exchangeRateEth = await CoinData('ETH', currency).getCoinData();
      setState(() {
        amountEth = exchangeRateEth.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
    try {
      double exchangeRateEth = await CoinData('LTC', currency).getCoinData();
      setState(() {
        amountLtc = exchangeRateEth.toStringAsFixed(0);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 BTC= $amountBtc $currency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 ETH= $amountEth $currency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      "1 LTC= $amountLtc $currency",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
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
