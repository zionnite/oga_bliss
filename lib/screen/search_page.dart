import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';

final pageBucket = PageStorageBucket();

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

  getIfAudioLoaded() {
    var loading = propsController.isSearchDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(new Duration(seconds: 4), () {
      getIfAudioLoaded();
    });
    propsController.fetch_search_page(current_page, widget.searchTerm, user_id);
  }

  void searchPage() {
    propsController.fetch_search_page(1, widget.searchTerm, user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      propsController.fetch_search_page_by_pagination(
          current_page, widget.searchTerm, user_id);

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
              if (propsController.searchPropertyList[index].propsId == null) {
                propsController.isMoreDataAvailable.value = false;
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
      ),
    );
  }
}
