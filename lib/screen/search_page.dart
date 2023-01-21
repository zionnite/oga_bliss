import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    required this.searchTerm,
  });

  final String searchTerm;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final propsController = PropertyController().getXID;
  late ScrollController _controller;

  var user_id = 1;
  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 15.0,
          right: 15,
        ),
        child: Obx(
          () => ListView.builder(
            key: const PageStorageKey<String>('allProperty'),
            physics: const ClampingScrollPhysics(),
            // itemExtent: 350,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: propsController.propertyList.length,
            itemBuilder: (BuildContext context, int index) {
              var props = propsController.propertyList[index];
              if (index == propsController.propertyList.length + 1 &&
                  isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (propsController.propertyList[index].propsId == null) {
                propsController.isMoreDataAvailable.value = false;
                return Container();
              }
              return PropertyWidget(
                props_image: props.propsImgName!,
                props_name: props.propsName!,
                props_type: 'buy',
                props_price: props.propsPrice!,
                isFav: (props.favourite! == 'true') ? true : false,
                props_bedroom: '1',
                props_bathroom: '3',
                props_toilet: '5',
                props_image_counter: '${props.countPropsImage!}',
                propertyModel: props,
              );
            },
          ),
        ),
      ),
    );
  }
}
