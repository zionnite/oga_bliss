import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      propsController.fetch_search_page(
          current_page, widget.searchTerm, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  getIfAudioLoaded() {
    var loading = propsController.isSearchDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
        propsController.isSearchDataProcessing.value = false;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(const Duration(seconds: 4), () {
      getIfAudioLoaded();
    });
  }

  showNotFound() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            Image.asset(
              'assets/images/data_not_found.png',
              fit: BoxFit.fitWidth,
            ),
            const Text(
              'Oops!... no data found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Lobster',
              ),
            ),
          ],
        ),
      ),
    );
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
      body: (widgetLoading)
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blue,
                size: 20,
              ),
            )
          : (propsController.searchPropertyList.isEmpty)
              ? showNotFound()
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
                        if (index ==
                                propsController.searchPropertyList.length + 1 &&
                            isLoading == true) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (propsController.searchPropertyList[index].propsId ==
                            null) {
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
