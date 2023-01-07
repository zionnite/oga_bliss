import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

import '../widget/search_widget.dart';

class SearchAlonePage extends StatefulWidget {
  const SearchAlonePage({Key? key}) : super(key: key);

  @override
  State<SearchAlonePage> createState() => _SearchAlonePageState();
}

class _SearchAlonePageState extends State<SearchAlonePage> {
  _SearchAlonePageState() {
    _selectedVal = _regionStateList[0];
  }
  final _regionStateList = [
    "Edo",
    "Delta",
    "Lagos",
    "Bayelsa",
    "Port-Harcourt"
  ];
  String? _selectedVal = "";
  late RangeValues _rangeValues = const RangeValues(100000, 70000000);

  String NGN = cSymbol("NGN");

  @override
  Widget build(BuildContext context) {
    RangeLabels _rangeLabels = RangeLabels(
      _rangeValues.start.toString(),
      _rangeValues.end.toString(),
    );
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'What are you looking for?',
                style: TextStyle(
                  wordSpacing: 5,
                  fontSize: 25,
                  fontFamily: 'Passion One',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'OgaBliss get you Covered',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: '',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SearchWidget(),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.black12,
                  height: 35,
                  margin: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Filter By',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Region and Area',
                          style: TextStyle(
                            // fontSize: 18,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 25,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'State',
                                  enabledBorder: OutlineInputBorder(
                                    //<-- SEE HERE

                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white30,
                                ),
                                isExpanded: true,
                                value: _selectedVal,
                                items: _regionStateList
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedVal = val.toString();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Area',
                                  enabledBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white30,
                                ),
                                isExpanded: true,
                                value: _selectedVal,
                                items: _regionStateList
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedVal = val.toString();
                                  });
                                },
                              ),
                            ),
                            Card(
                              color: Colors.white70,
                              child: Container(
                                margin: const EdgeInsets.only(),
                                padding: const EdgeInsets.all(22.8),
                                child: const Text('Go'),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Property Types',
                          style: TextStyle(
                            // fontSize: 18,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 15,
                        ),
                        color: Colors.white,
                        child: ListView(
                          padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: const [
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('House'),
                              ),
                              trailing: Icon(Icons.send),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black38,
                            ),
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Land'),
                              ),
                              trailing: Icon(Icons.send),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black38,
                            ),
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Land'),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black38,
                            ),
                            ListTile(
                              title: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Land'),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Price',
                          style: TextStyle(
                            // fontSize: 18,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                      ),
                      RangeSlider(
                        min: 10000,
                        max: 90000000,
                        divisions: 10,
                        labels: _rangeLabels,
                        values: _rangeValues,
                        onChanged: (val) {
                          setState(() {
                            _rangeValues = val;
                          });
                        },
                      ),
                      Container(
                        // margin: const EdgeInsets.only(left: 20.0),
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  '$NGN ' +
                                      currencyFormat(_rangeValues.start,
                                          locale: 'en_US', symbol: ""),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  '$NGN ' +
                                      currencyFormat(_rangeValues.end,
                                          locale: 'en_US', symbol: ""),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            barrierColor: Colors.blue[40],
                            isDismissible: true,
                            enableDrag: false,
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              color: Colors.white,
                              height: 250,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25, top: 30),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'State',
                                              enabledBorder: OutlineInputBorder(
                                                //<-- SEE HERE

                                                borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 2,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white30,
                                            ),
                                            isExpanded: true,
                                            value: _selectedVal,
                                            items: _regionStateList
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                _selectedVal = val.toString();
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              labelText: 'Area',
                                              enabledBorder: OutlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                  color: Colors.black12,
                                                  width: 2,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white30,
                                            ),
                                            isExpanded: true,
                                            value: _selectedVal,
                                            items: _regionStateList
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            onChanged: (val) {
                                              setState(() {
                                                _selectedVal = val.toString();
                                              });
                                            },
                                          ),
                                        ),
                                        Card(
                                          color: Colors.white70,
                                          child: Container(
                                            margin: const EdgeInsets.only(),
                                            padding: const EdgeInsets.all(22.8),
                                            child: const Text('Go'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Card(
                                      color: Colors.red,
                                      margin: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 30,
                                        right: 30,
                                        bottom: 10,
                                      ),
                                      elevation: 3,
                                      child: Container(
                                        width: double.infinity,
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                            top: 20.0,
                                            left: 40,
                                            right: 40,
                                            bottom: 20,
                                          ),
                                          child: Text(
                                            'Close',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            margin: EdgeInsets.only(top: 15, bottom: 15),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 13.0,
                                bottom: 13.0,
                                right: 25,
                                left: 25,
                              ),
                              child: Ink(
                                color: Colors.white,
                                child: Text('Filter by Price'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
