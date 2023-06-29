import 'package:get/get.dart';
import 'package:oga_bliss/model/link_activity_model.dart';
import 'package:oga_bliss/model/marketing_model.dart';
import 'package:oga_bliss/services/api_services.dart';

class MarketController extends GetxController {
  MarketController get getXID => Get.find<MarketController>();

  var page_num = 1;
  var isMarketProcessing = 'null'.obs;
  var marketList = <ProductPromoting>[].obs;
  //
  var isLinkProcessing = 'null'.obs;
  var linkList = <LinkActivity>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  fetchPromotingProduct({required int pageNum, required String user_id}) async {
    var seeker = await ApiServices.getProductPromoting(
        pageNum: pageNum, userId: user_id);
    if (seeker != null) {
      isMarketProcessing.value = 'yes';
      marketList.value = seeker.cast<ProductPromoting>();
    } else {
      isMarketProcessing.value = 'no';
    }
  }

  fetchPomotingProductMore(
      {required int pageNum, required String user_id}) async {
    var seeker = await ApiServices.getProductPromoting(
        pageNum: pageNum, userId: user_id);
    if (seeker != null) {
      marketList.addAll(seeker.cast<ProductPromoting>());
    } else {}
  }

  fetchLinkActivity(
      {required int pageNum,
      required String user_id,
      required String props_id}) async {
    var seeker = await ApiServices.getLinkActivity(
        pageNum: pageNum, userId: user_id, propsId: props_id);
    if (seeker != null) {
      isLinkProcessing.value = 'yes';
      linkList.value = seeker.cast<LinkActivity>();
    } else {
      linkList.clear();
      isLinkProcessing.value = 'no';
    }
  }

  fetchLinkActivityMore(
      {required int pageNum,
      required String user_id,
      required String props_id}) async {
    var seeker = await ApiServices.getLinkActivity(
        pageNum: pageNum, userId: user_id, propsId: props_id);
    if (seeker != null) {
      linkList.addAll(seeker.cast<LinkActivity>());
    } else {}
  }
}
