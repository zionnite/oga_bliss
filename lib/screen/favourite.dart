import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
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

      propsController.fetch_favourite(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  getIfAudioLoaded() {
    var loading = propsController.isSearchDataProcessing.value;
    if (loading || !loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(new Duration(seconds: 4), () {
      getIfAudioLoaded();
    });
  }

  void searchPage() {
    propsController.fetch_favourite(1, user_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      //

      propsController.fetch_more_favourite(current_page, user_id);

      Future.delayed(new Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text('Favourite'),
      ),
      body: (propsController.favPropertyList.isEmpty)
          ? showNotFound()
          : Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 15.0,
                right: 15,
              ),
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 120),
                  controller: _controller,
                  key: const PageStorageKey<String>('allFavourite'),
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: propsController.favPropertyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var props = propsController.favPropertyList[index];
                    if (index == propsController.favPropertyList.length + 1 &&
                        isLoading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (propsController.favPropertyList[index].propsId ==
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
                      route: 'fav',
                    );
                  },
                ),
              ),
            ),
    );
  }
}
