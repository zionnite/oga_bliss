import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/my_point_item.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/point_items.dart';
import 'package:oga_bliss/services/api_services.dart';

class PointItemController extends GetxController {
  PointItemController get getXID => Get.find<PointItemController>();

  var pointItemList = <PointItem>[].obs;
  var isPointItemProcessing = 'null'.obs;

  var myPointItemList = <MyPointItem>[].obs;
  var isMyPointItemProcessing = 'null'.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getPointItem(pageNum, userId) async {
    var seeker = await ApiServices.getAllPointItem(pageNum, userId);
    if (seeker != null) {
      isPointItemProcessing.value = 'yes';
      pointItemList.value = seeker.cast<PointItem>();
    } else {
      isPointItemProcessing.value = 'no';
    }
  }

  getMyPointItem(pageNum, userId) async {
    var seeker = await ApiServices.getMyPointItem(pageNum, userId);
    if (seeker != null) {
      isMyPointItemProcessing.value = 'yes';
      myPointItemList.value = seeker.cast<MyPointItem>();
    } else {
      isMyPointItemProcessing.value = 'no';
    }
  }

  getMyPointItemMore(pageNum, userId) async {
    var seeker = await ApiServices.getMyPointItem(pageNum, userId);
    if (seeker != null) {
      myPointItemList.addAll(seeker.cast<MyPointItem>());
    } else {}
  }
}
