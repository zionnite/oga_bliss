import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';

class FilterByPrice extends StatefulWidget {
  FilterByPrice({
    required this.startPrice,
    required this.endPrice,
  });

  final String startPrice;
  final String endPrice;

  @override
  State<FilterByPrice> createState() => _FilterByPriceState();
}

class _FilterByPriceState extends State<FilterByPrice> {
  final propsController = PropertyController().getXID;
  late ScrollController _controller;

  String? user_id;
  String? user_status;
  bool? admin_status;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
      });

      propsController.filter_search_page_price(
          current_page, widget.startPrice, widget.endPrice, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  void initState() {
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);
  }

  void searchPage() {
    propsController.filter_search_page_price(
        1, widget.startPrice, widget.endPrice, user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      propsController.filter_search_page_price_by_pagination(
          current_page, widget.startPrice, widget.endPrice, user_id);

      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorPrimary,
      ),
      body: Obx(
        () => (propsController.isPriceProcessing == 'null')
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blue,
                  size: 20,
                ),
              )
            : detail(),
      ),
    );
  }

  Widget detail() {
    return (propsController.searchPropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isPriceProcessing.value = 'null';
                    propsController.filter_search_page_price(current_page,
                        widget.startPrice, widget.endPrice, user_id);
                    propsController.searchPropertyList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ])
        : Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 15.0,
              right: 15,
            ),
            child: Obx(
              () => ListView.builder(
                controller: _controller,
                key: const PageStorageKey<String>('allFilter'),
                physics: const ClampingScrollPhysics(),
                // itemExtent: 350,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: propsController.searchPropertyList.length,
                itemBuilder: (BuildContext context, int index) {
                  var props = propsController.searchPropertyList[index];
                  if (index == propsController.searchPropertyList.length + 1 &&
                      isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (propsController.searchPropertyList[index].propsId ==
                      null) {
                    return Container();
                  }
                  return PropertyWidget(
                    props_image: props.propsImgName!,
                    props_name: props.propsName!,
                    props_type: props.propsPurpose!,
                    props_price: props.propsPrice!,
                    isFav: (props.favourite! == 'true') ? true : false,
                    props_bedroom: props.propsBedrom!,
                    props_bathroom: props.propsBathroom!,
                    props_toilet: props.propsToilet!,
                    props_image_counter: '${props.countPropsImage!}',
                    propertyModel: props,
                    route: 'search',
                  );
                },
              ),
            ),
          );
  }
}
