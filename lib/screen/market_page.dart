import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/market_controller.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/screen/link_activity.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:oga_bliss/widget/small_btn_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  final usersController = UsersController().getXID;
  final marketController = MarketController().getXID;

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

      await marketController.fetchPromotingProduct(
          pageNum: 1, user_id: user_id!);
    }
  }

  var current_page = 1;

  bool isLoading = false;
  int selectedItem = -1;

  @override
  void initState() {
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        current_page++;
      });

      marketController.fetchPomotingProductMore(
          pageNum: current_page, user_id: user_id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Product Marketing'),
          Expanded(
            child: Obx(
              () => (marketController.isMarketProcessing == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  : detail(),
            ),
          ),
        ],
      ),
    );
  }

  Widget detail() {
    return (marketController.marketList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    marketController.isMarketProcessing.value = 'null';
                    marketController.fetchPromotingProduct(
                        pageNum: 1, user_id: user_id!);
                    marketController.marketList.refresh();
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
              // key: UniqueKey(),
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 120),
              key: const PageStorageKey<String>('allTransaction'),
              physics: const ClampingScrollPhysics(),
              // itemExtent: 350,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: marketController.marketList.length,
              itemBuilder: (BuildContext context, int index) {
                var m_data = marketController.marketList[index];
                if (marketController.marketList[index].id == null) {
                  return Container();
                }

                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => ViewPropertyDetailedDashboard(
                              propsId: '${m_data.propsId}',
                              route: 'dashboard',
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 85,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          '${m_data.propsImage}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${m_data.propsName}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                                  amount:
                                                      '${m_data.propsAmount}'),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 1, left: 2, right: 2),
                                                color: Colors.blue.shade50,
                                                child: Text(
                                                  'for marketing property Your get: ${CurrencyFormatter.getCurrencyFormatter(amount: '${m_data.promoterPerc}')}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Row(
                          children: [
                            smallBtnIcon(
                              btnName: 'link activities',
                              btnColor: Colors.blue.shade900,
                              onTap: () {
                                Get.to(
                                  () => LinkActivity(
                                    userId: user_id!,
                                    propsId: m_data.propsId!,
                                  ),
                                );
                              },
                              icon: Icons.add_chart_rounded,
                              icon_color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            smallBtnIcon(
                              btnName: 'copy link',
                              btnColor: Colors.blue.shade900,
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                  selectedItem = index;
                                });

                                Future.delayed(const Duration(seconds: 1),
                                    () async {
                                  setState(() {
                                    selectedItem = -1;
                                    isLoading = false;
                                  });
                                });
                                var link =
                                    '${baseDomain}Product/view_product/${m_data.propsId}/${m_data.urlCode}';
                                Clipboard.setData(ClipboardData(text: link))
                                    .then((_) {
                                  showSnackBar(
                                    title: 'Link',
                                    msg: 'Property Link Copied',
                                    backgroundColor: Colors.blue.shade900,
                                  );
                                });
                              },
                              icon: Icons.copy,
                              icon_color: Colors.white,
                              item: index,
                              selecteditem: selectedItem,
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}
