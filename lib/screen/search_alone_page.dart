import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:oga_bliss/widget/my_dropdown_field.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

import '../controller/property_controller.dart';
import '../model/state_model.dart';
import '../widget/search_widget.dart';
import 'filter_by_location.dart';
import 'filter_by_price.dart';
import 'filter_by_type.dart';

class SearchAlonePage extends StatefulWidget {
  const SearchAlonePage({Key? key}) : super(key: key);

  @override
  State<SearchAlonePage> createState() => _SearchAlonePageState();
}

class _SearchAlonePageState extends State<SearchAlonePage> {
  final propsController = PropertyController().getXID;

  List<States> stateList = [];
  List<Area> areaList = [];
  List<Area> areaTempList = [];

  String? states_id;
  String? area_id;

  populateDropDown() async {
    LocationModel data = await ApiServices.getStateRegion();
    setState(() {
      stateList = data.states;
      areaList = data.area;
    });
  }

  @override
  void initState() {
    super.initState();
    populateDropDown();
  }

  late RangeValues _rangeValues = const RangeValues(5000, 70000000);
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
                            fontSize: 12,
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
                              child: MyDropDownField(
                                labelText: 'State',
                                value: states_id,
                                dropDownList: stateList.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    area_id = null;
                                    states_id = value.toString();
                                    areaTempList = areaList
                                        .where(
                                          (element) =>
                                              element.stateId.toString() ==
                                              states_id.toString(),
                                        )
                                        .toList();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyDropDownField(
                                labelText: 'Area',
                                value: area_id,
                                dropDownList: areaTempList.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    area_id = value.toString();
                                  });
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (states_id != null && area_id != null) {
                                  Get.to(
                                    () => FilterByLocation(
                                      state_id: states_id!,
                                      area_id: area_id!,
                                    ),
                                  );
                                }
                              },
                              child: Card(
                                color: Colors.white70,
                                child: Container(
                                  margin: const EdgeInsets.only(),
                                  padding: const EdgeInsets.all(22.8),
                                  child: const Text('Go'),
                                ),
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
                            fontSize: 12,
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
                        child: Obx(
                          () => ListView.builder(
                            itemCount: propsController.typesPropertyList.length,
                            padding: const EdgeInsets.only(
                                top: 10, left: 0, right: 0),
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var type =
                                  propsController.typesPropertyList[index];
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => FilterByType(
                                          typeId: type.id,
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(type.name),
                                      ),
                                      trailing: const Icon(Icons.send),
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: Colors.black38,
                                  ),
                                ],
                              );
                            },
                          ),
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
                            fontSize: 12,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                      ),
                      RangeSlider(

                        min: 5000,
                        max: 90000000,
                        divisions: 100000,
                        // labels: _rangeLabels,
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
                          Get.to(
                            () => FilterByPrice(
                              startPrice: _rangeValues.start.toString(),
                              endPrice: _rangeValues.end.toString(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
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
                                child: const Text('Filter by Price'),
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

  void onStateChange(state) {
    setState(() {});
    // String endpoint = "$baseURL/api/pin/${selectedState.state}";
    // listState(endpoint).then((List<PostOffice> value) {
    //   setState(() {
    //     districts = value;
    //   });
    // });
  }
}
