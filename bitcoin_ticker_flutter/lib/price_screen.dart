import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String rate = '...';
  String theCryptoName = 'BTC';

  DropdownButton<String> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var theList = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropDownItems.add(theList);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPickerItems() {
    List<Widget> cupertinoItems = [];

    for (String currency in currenciesList) {
      Widget a = Text(currency);
      cupertinoItems.add(a);
    }

    return CupertinoPicker(
      itemExtent: 35,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = currenciesList[value];
          getData();
        });
      },
      children: cupertinoItems,
    );
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;

  void getData() async {
    // var theText;
    // try {
    //   final String data = await CoinData().getExchangeData(
    //     theCurrency: selectedCurrency,
    //     theCryptoName: cryptoName,
    //   );
    //   setState(() {
    //     rate = data;
    //     theText = '1 $cryptoName = $rate $selectedCurrency';
    //   });
    // } catch (e) {
    //   print(e);
    // }
    // return theText;
    isWaiting = true;
    try {
      Map<String, String> data =
          await CoinData().getExchangeData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TheEntireCard(
                value: isWaiting ? '...' : coinValues['BTC'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'BTC',
              ),
              TheEntireCard(
                value: isWaiting ? '...' : coinValues['ETH'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'ETH',
              ),
              TheEntireCard(
                value: isWaiting ? '...' : coinValues['LTC'],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'LTC',
              )
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // For iOS, use the cupertino picker to achieve that iOS specific look on the scroller. https://docs.flutter.dev/development/ui/widgets/cupertino
            child:
                Platform.isIOS ? getCupertinoPickerItems() : getDropDownItems(),
          )
        ],
      ),
    );
  }
}

class TheEntireCard extends StatelessWidget {
  const TheEntireCard({
    Key? key,
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  }) : super(key: key);
  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
