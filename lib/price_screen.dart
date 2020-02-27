import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  CoinData coinData = CoinData();
//  int btcToCurrency;
//  int ethToCurrency;
//  int ltcToCurrency;
//
//  ConvertedCurrency convertedCurrency = ConvertedCurrency();

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) async {
        setState(
          () {
            selectedCurrency = value;
            getResult();
          },
        );
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            selectedCurrency = currenciesList[selectedIndex];
            getResult();
          },
        );
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;
  void getResult() async {
    isWaiting = true;
    try {
      var data = await CoinData().getData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getResult();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCurrencyCard(
                cryptoCurrency: 'BTC',
                currency: selectedCurrency,
                convertedCurrency: isWaiting ? '?' : coinValues['BTC'],
              ),
              CryptoCurrencyCard(
                cryptoCurrency: 'ETH',
                currency: selectedCurrency,
                convertedCurrency: isWaiting ? '?' : coinValues['ETH'],
              ),
              CryptoCurrencyCard(
                cryptoCurrency: 'LTC',
                currency: selectedCurrency,
                convertedCurrency: isWaiting ? '?' : coinValues['LTC'],
              ),
            ],
          ),
          Container(
            height: 140.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10.0),
            color: Color.fromRGBO(16, 24, 32, 1),
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCurrencyCard extends StatelessWidget {
  CryptoCurrencyCard({
    @required this.cryptoCurrency,
    @required this.currency,
    @required this.convertedCurrency,
  });

  final String cryptoCurrency;
  final String currency;
  final String convertedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color.fromRGBO(16, 24, 32, 1),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $convertedCurrency $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
