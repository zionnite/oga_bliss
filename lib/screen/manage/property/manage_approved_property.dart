import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/widget/property_widget.dart';

import '../../../controller/property_controller.dart';

class ManageAllApprovedProperty extends StatefulWidget {
  const ManageAllApprovedProperty({Key? key}) : super(key: key);

  @override
  State<ManageAllApprovedProperty> createState() =>
      _ManageAllApprovedPropertyState();
}

class _ManageAllApprovedPropertyState extends State<ManageAllApprovedProperty> {
  final propsController = PropertyController().getXID;

  var user_id = 1;
  bool isLoading = false;

  @override
  void initState() {
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
