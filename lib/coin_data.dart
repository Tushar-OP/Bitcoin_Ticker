import 'package:http/http.dart' as http;
import 'dart:convert';

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

const bitcoinTickerAPIURL = "https://min-api.cryptocompare.com/data/price";

class CoinData {
  Future getData(String currency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String bitcoinURL = "$bitcoinTickerAPIURL?fsym=$crypto&tsyms=$currency";
      http.Response response = await http.get(bitcoinURL);

      if (response.statusCode == 200) {
        String body = response.body;
        var decodedData = jsonDecode(body);
        double convertedPrice = decodedData[currency];
        cryptoPrices[crypto] = convertedPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
