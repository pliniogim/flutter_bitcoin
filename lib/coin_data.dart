import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../util/constantes.dart';

class CoinData {
  static const List<String> currenciesList = [
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
  static const List<String> cryptoList = [
    'BTC',
    'ETH',
    'LTC',
  ];

  List<String> pegaListadeMoedas() {
    return currenciesList;
  }

  Future onlineRequest(passedCurrency) async {
    List<double> rateList = [];
    for (int i = 0; i < cryptoList.length; i++) { //or for(String i in cryptoList)
      http.Response response = await http.get(Uri.parse('$url${cryptoList[i]}/$passedCurrency?apikey=$coinApiKey'));
      if (response.statusCode == 200) {
        var decodedData = convert.jsonDecode(response.body);
        var rate = decodedData['rate'];
        rateList.add(rate);
      } else {
        throw 'Problema com o get: $response.statusCode.toString()';
      }
    }
    return rateList;
  }
}