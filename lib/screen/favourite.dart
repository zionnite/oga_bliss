import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';
import '../widget/show_not_found.dart';

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
  bool? guestStatus;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isGuestLogin = prefs.getBool('isGuestLogin');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        guestStatus = isGuestLogin;
      });

      propsController.fetch_favourite(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  void initState() {
    propsController.favPropertyList.clear();
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (mounted) {
        setState(() {
          isLoading = true;
          current_page++;
        });
      }

      propsController.fetch_more_favourite(current_page, user_id);

      Future.delayed(new Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColorPrimary,
        title: const Text('Favourite'),
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 15.0,
          right: 15,
        ),
        child: Obx(
          () => (propsController.isFavProcessing == 'null')
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 30,
                  ),
                )
              : detail(),
        ),
      ),
    );
  }

  Widget detail() {
    return (propsController.isFavProcessing == 'no')
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isFavProcessing.value = 'null';
                    propsController.fetch_favourite(1, user_id);
                    propsController.favPropertyList.refresh();
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
        : Obx(
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
                if (propsController.favPropertyList[index].propsId == null) {
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
          );
  }
}
