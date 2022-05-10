import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'BRL';

  CoinData coinData = CoinData();

  Widget getPicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      //return androidDropDownButton();
      return iosPicker();
    }
    return androidDropDownButton();
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> listadeMoedas = [];
    List<String> moedas = coinData.pegaListadeMoedas();

    for (String moeda in moedas) {
      listadeMoedas.add(
        DropdownMenuItem(
          child: Text(moeda),
          value: moeda,
        ),
      );
    }

    //android specific
    return DropdownButton<String>(
      dropdownColor: Colors.indigo,
      itemHeight: kMinInteractiveDimension,
      isDense: true,
      value: selectedCurrency,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
          },
        );
      },
      items: listadeMoedas,
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> listadeMoedas = [];
    List<String> moedas = coinData.pegaListadeMoedas();
    for (String moeda in moedas) {
      listadeMoedas.add(
        Text(moeda),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 36.0,
      onSelectedItemChanged: (selectIndex) {
        //print(selectIndex);
      },
      children: listadeMoedas,
    );
  }

  // List<DropdownMenuItem<String>> retornaItemsDropDown() {
  //   List<DropdownMenuItem<String>> listadeMoedas = [];
  //   List<String> moedas = coinData.pegaListadeMoedas();
  //   //print(moedas);
  //   // for (int i = 0; i < moedas.length; i++) {
  //   //   listadeMoedas.add(
  //   //     DropdownMenuItem(
  //   //       child: Text(moedas[i]),
  //   //       value: moedas[i],
  //   //     ),
  //   //   );
  //   for (String moeda in moedas) {
  //     listadeMoedas.add(
  //       DropdownMenuItem(
  //         child: Text(moeda),
  //         value: moeda,
  //       ),
  //     );
  //   }
  //   return listadeMoedas;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
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
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //
            //ternary mode
            child: Platform.isIOS ? iosPicker(): iosPicker(), //androidDropDownButton()
            //
            //one way
            //child: getPicker(),
            //
            // child: CupertinoPicker(
            //   backgroundColor: Colors.lightBlue,
            //   itemExtent: 36.0,
            //   onSelectedItemChanged: (selectIndex) {
            //     //print(selectIndex);
            //   },
            //   children: getPickerItems(),
            // ),
            //android specific
            //   DropdownButton<String>(
            //   dropdownColor: Colors.indigo,
            //   itemHeight: kMinInteractiveDimension,
            //   isDense: true,
            //   value: selectedCurrency,
            //   onChanged: (value) {
            //     setState(() {
            //       selectedCurrency = value!;
            //     });
            //   },
            //   items: retornaItemsDropDown(),
            // ),
          ),
        ],
      ),
    );
  }
}