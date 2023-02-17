import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/screen/front/welcome_page.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../widget/property_widget.dart';
import '../widget/search_widget.dart';

final pageBucket = PageStorageBucket();

class AllPropertyPage extends StatefulWidget {
  const AllPropertyPage({required this.s_key});
  final GlobalKey<ScaffoldState> s_key;
  @override
  State<AllPropertyPage> createState() => _AllPropertyPageState();
}

class _AllPropertyPageState extends State<AllPropertyPage> {
  final propsController = PropertyController().getXID;
  final usersController = UsersController().getXID;
  late ScrollController _controller;

  String? user_id;
  String? user_status;
  bool? admin_status;
  bool? isUserLogin;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isUserLogin1 = prefs.getBool('isUserLogin');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        isUserLogin = isUserLogin1;
      });

      await propsController.getDetails(user_id);
      await usersController.checkForUpdate(user_id);
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

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.getMoreDetail(current_page, user_id);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // key: _key,
      // drawer: NavigationDrawerWidget(),
      body: PageStorage(
        bucket: pageBucket,
        child: SingleChildScrollView(
          controller: _controller,
          key: const PageStorageKey<String>('allProperty'),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 450,
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 39,
                        ),
                        onPressed: () async {
                          (isUserLogin == null)
                              ? showSnackBar(
                                  title: 'Oops',
                                  msg:
                                      'You are not authenticated, you need to register or Login to be authenticated',
                                  backgroundColor: Colors.red)
                              : Container();
                          (isUserLogin == null)
                              ? Get.to(() => const WelcomePage())
                              : widget.s_key.currentState!.openDrawer();
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Text(
                            'Find Your Dream',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Passion One',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lobster',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SearchWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Obx(
                () => (propsController.isHomeFetchProcessing == 'null')
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 550,
                          ),
                          Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    : detail(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detail() {
    return (propsController.propertyList.isEmpty)
        ? Column(
            children: [
              const SizedBox(
                height: 380,
              ),
              Stack(children: [
                const ShowNotFound(),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        propsController.isHomeFetchProcessing.value = 'null';
                        propsController.getDetails(user_id);
                        propsController.propertyList.refresh();
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
              ]),
            ],
          )
        : Column(
            children: [
              const SizedBox(
                height: 350,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 20.0, left: 20.0, bottom: 120),
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
                        route: 'default',
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
