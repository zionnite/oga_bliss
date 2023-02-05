import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late ScrollController _controller;

  String? user_id;
  String? user_status;
  bool? admin_status;

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

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
    }
  }

  checkIfListLoaded() {
    var loading = propsController.isDataProcessing.value;
    if (loading) {
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
      if (mounted) {
        setState(() {
          checkIfListLoaded();
        });
      }
    });

    // propsController.getDetails(1);
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
                        onPressed: () {
                          // Scaffold.of(context).openDrawer();
                          widget.s_key.currentState!.openDrawer();
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
              (propsController.propertyList.isEmpty)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 350,
                        ),
                        const Text(
                          'Oops!... no data found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                        Container(
                          height: height * 0.6,
                          // margin: const EdgeInsets.only(
                          //     left: 59, right: 59, top: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.blue.withOpacity(1),
                                BlendMode.color,
                              ),
                              fit: BoxFit.fitWidth,
                              image: const AssetImage(
                                'assets/images/data_not_found.png',
                              ),
                            ),
                          ),
                        ),
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
                                if (index ==
                                        propsController.propertyList.length +
                                            1 &&
                                    isLoading == true) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (propsController
                                        .propertyList[index].propsId ==
                                    null) {
                                  propsController.isMoreDataAvailable.value =
                                      false;
                                  return Container();
                                }
                                return PropertyWidget(
                                  props_image: props.propsImgName!,
                                  props_name: props.propsName!,
                                  props_type: props.propsPurpose!,
                                  props_price: props.propsPrice!,
                                  isFav: (props.favourite! == 'true')
                                      ? true
                                      : false,
                                  props_bedroom: props.propsBedrom!,
                                  props_bathroom: props.propsBathroom!,
                                  props_toilet: props.propsToilet!,
                                  props_image_counter:
                                      '${props.countPropsImage!}',
                                  propertyModel: props,
                                  route: 'default',
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
