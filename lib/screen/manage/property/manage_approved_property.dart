import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/widget/property_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/property_controller.dart';

class ManageAllApprovedProperty extends StatefulWidget {
  const ManageAllApprovedProperty({Key? key}) : super(key: key);

  @override
  State<ManageAllApprovedProperty> createState() =>
      _ManageAllApprovedPropertyState();
}

class _ManageAllApprovedPropertyState extends State<ManageAllApprovedProperty> {
  final propsController = PropertyController().getXID;

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
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0, bottom: 120),
      child: Obx(
        () => ListView.builder(
          key: const PageStorageKey<String>('allProperty'),
          physics: const ClampingScrollPhysics(),
          // itemExtent: 350,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: propsController.approvedPropertyList.length,
          itemBuilder: (BuildContext context, int index) {
            var props = propsController.approvedPropertyList[index];
            if (index == propsController.approvedPropertyList.length + 1 &&
                isLoading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (propsController.approvedPropertyList[index].propsId == null) {
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
              route: 'default',
              adminStatus: true,
              adminTap: 'approved',
            );
          },
        ),
      ),
    );
  }
}
