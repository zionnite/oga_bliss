import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseProperty extends StatefulWidget {
  const PurchaseProperty({Key? key}) : super(key: key);

  @override
  State<PurchaseProperty> createState() => _PurchasePropertyState();
}

class _PurchasePropertyState extends State<PurchaseProperty> {
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

      await propsController.getPropertyPurchase(user_id, admin_status);
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

      propsController.getMorePropertyPurchase(
          current_page, user_id, admin_status);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Purchase Property'),
          Expanded(
            child: Obx(
              () => (propsController.isPurchasePropertyProcessing == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  : detail(),
            ),
          )
        ],
      ),
    );
  }

  Widget detail() {
    return (propsController.purchasePropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isPurchasePropertyProcessing.value = 'null';
                    propsController.getPropertyPurchase(user_id, admin_status);
                    propsController.purchasePropertyList.refresh();
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
        : SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.all(0),
                    key: const PageStorageKey<String>('myProperty'),
                    physics: const ClampingScrollPhysics(),
                    // itemExtent: 350,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: propsController.purchasePropertyList.length,

                    itemBuilder: (BuildContext context, int index) {
                      var props = propsController.purchasePropertyList[index];

                      if (propsController.purchasePropertyList[index].disId ==
                          null) {
                        return Container();
                      }

                      // print('${props.dateCreated}');

                      String startDate = DateFormat('EEEE, MMM d, yyyy')
                          .format(props.dateCreated!);
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => ViewPropertyDetailedDashboard(
                              propsId: props.propsId!,
                              route: 'dashboard',
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    props.propsImgName!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              props.propsName!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              startDate,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: (props.propStatus == 'pending')
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
