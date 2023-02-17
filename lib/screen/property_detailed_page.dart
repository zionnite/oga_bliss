import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/header_title.dart';
import 'package:oga_bliss/widget/property_key_and_value.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/favourite_controller.dart';
import '../controller/property_controller.dart';
import '../widget/amenities_widget.dart';
import '../widget/property_btn.dart';

class PropertyDetailPage extends StatefulWidget {
  PropertyDetailPage({this.propertyModel, required this.route});

  PropertyModel? propertyModel;
  String route;
  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late FlutterYoutubeViewController _controller;
  YoutubeScaleMode _mode = YoutubeScaleMode.none;
  final propsController = PropertyController().getXID;
  final favController = FavouriteController().getXID;

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
  List<String> images = [];

  loopSlider() {
    images.clear();
    var props = widget.propertyModel!.getAllPropsImage;
    for (var i = 0; i < props!.length; i++) {
      images.add(props[i]!.imageName.toString());
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
    loopSlider();
  }

  void showPropertyImage() {
    (images.isEmpty)
        ? Get.defaultDialog(
            title: 'Oops!',
            radius: 2,
            content: const Center(
              child: Text('Photos is not available'),
            ),
            cancel: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ok',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : PopupBanner(
            context: context,
            fit: BoxFit.cover,
            images: images,
            dotsAlignment: Alignment.bottomCenter,
            dotsColorActive: Colors.blue,
            dotsColorInactive: Colors.grey.withOpacity(0.5),
            onClick: (index) {
              // debugPrint("CLICKED $index");
            },
          ).show();
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  showPropertyVideo() {
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 0,
          right: 0,
          bottom: 0,
        ),
        color: Colors.blue,
        width: double.infinity,
        height: 650,
        child: Column(
          children: [
            const HeaderTitle(title: 'Quick Watch'),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 300,
                child: FlutterYoutubeView(
                  onViewCreated: _onYoutubeCreated,
                  // listener: this,
                  scaleMode:
                      YoutubeScaleMode.none, // <option> fitWidth, fitHeight
                  params: YoutubeParam(
                    videoId: widget.propertyModel!.propsVidId.toString(),
                    showUI: false,
                    startSeconds: 0.0, // <option>
                    autoPlay: true,
                  ), // <option>
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var props = widget.propertyModel;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Image.network(
                      props!.sliderImg.toString(),
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/a.jpeg',
                          fit: BoxFit.fitWidth,
                        );
                      },
                      loadingBuilder: (context, Widget child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          height: 300,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 60,
                      left: 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(35),
                                ),
                                border: Border.all(
                                  color: Colors.blue.shade100,
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (user_status == 'user')
                        ? Positioned(
                            top: 57,
                            right: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    bool status =
                                        await propsController.toggleLike(
                                            user_id,
                                            widget.propertyModel!.propsId,
                                            widget.propertyModel!,
                                            widget.route,
                                            user_status);

                                    setState(() {
                                      props!.favourite = status;
                                      if (widget.route == 'default') {
                                        int index = propsController.propertyList
                                            .indexOf(props);
                                        propsController.propertyList[index]
                                            .favourite = status;
                                      } else if (widget.route == 'search') {
                                        int index = propsController
                                            .searchPropertyList
                                            .indexOf(props);
                                        propsController
                                            .searchPropertyList[index]
                                            .favourite = status;
                                      } else if (widget.route == 'fav') {
                                        int index = propsController
                                            .favPropertyList
                                            .indexOf(props);
                                        propsController.favPropertyList[index]
                                            .favourite = status;

                                        if (status == false) {
                                          var propsId = propsController
                                              .favPropertyList[index].propsId;

                                          var newPropId = propsController
                                              .propertyList
                                              .indexWhere(((p) =>
                                                  p.propsId == propsId));

                                          if (newPropId != -1) {
                                            propsController
                                                .propertyList[newPropId]
                                                .favourite = status;
                                          }

                                          //remove from favPropertyList
                                          propsController.favPropertyList
                                              .removeAt(index);
                                        }
                                      } else if (widget.route == 'dashboard') {
                                        int index = propsController
                                            .disPropertyList
                                            .indexOf(props);
                                        propsController.disPropertyList[index]
                                            .favourite = status;

                                        if (status == false || status == true) {
                                          var propsId = propsController
                                              .disPropertyList[index].propsId;

                                          var newPropId = propsController
                                              .propertyList
                                              .indexWhere(((p) =>
                                                  p.propsId == propsId));

                                          if (newPropId != -1) {
                                            propsController
                                                .propertyList[newPropId]
                                                .favourite = status;
                                          }

                                          //update myPropertyList
                                        }
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(35),
                                      ),
                                      border: Border.all(
                                        color: Colors.blue.shade100,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: (props.favourite == true)
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.blue,
                                              size: 30,
                                            )
                                          : const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.black54,
                                              size: 30,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showPropertyImage();
                        },
                        child: Material(
                          elevation: 2,
                          color: Colors.black,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white30,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 50,
                                left: 50,
                              ),
                              child: Text(
                                'Photos',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showPropertyVideo();
                        },
                        child: Material(
                          elevation: 2,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                right: 50,
                                left: 50,
                              ),
                              child: Text(
                                'Video',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 5,
                          ),
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          color: Colors.red[900],
                          child: Text(
                            props.propsPurpose.toString().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 1,
                            right: 1,
                          ),
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                            top: 5,
                            bottom: 5,
                          ),
                          color: Colors.red[900],
                          child: Text(
                            props.propsStatus.toString().toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 5,
                              bottom: 5,
                            ),
                            color: Colors.lightGreen[900],
                            child: Text(
                              CurrencyFormatter.getCurrencyFormatter(
                                amount: "${props.propsPrice}",
                              ),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'BlackOpsOne',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    'Property Name - ${props.propsName}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'Passion One',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    props.propsDescription.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: const Text(
                    '-CONDITION-',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Passion One',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    props.propsCondition.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: const Text(
                    '-SPECIAL PREFERENCE-',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Passion One',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    props.propsSpecialPref.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: const Text(
                    '-Caution Fee-',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Passion One',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    CurrencyFormatter.getCurrencyFormatter(
                      amount: props.propsCautionFee.toString(),
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Divider(
                  height: 1,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: HeaderTitle(
                  title: 'Details',
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    PropertyKeyAndValue(
                      propsKey: 'Type',
                      propsValue: props.typeName.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Sub-Type',
                      propsValue: props.subTypeName.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Purpose',
                      propsValue: props.propsPurpose.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Status',
                      propsValue: props.propsStatus.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Bedrooms',
                      propsValue: props.propsBedrom.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Bathrooms',
                      propsValue: props.propsBathroom.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Toilets',
                      propsValue: props.propsToilet.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Year Built',
                      propsValue: props.propsYearBuilt.toString(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Divider(
                  height: 1,
                  color: Colors.black54,
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: HeaderTitle(
                  title: 'AMENITIES',
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                  child: Column(
                    children: [
                      AmenitiesWidget(
                        isYes: props.propsAirCondition.toString(),
                        name: 'Air Conditioning',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsCableTv.toString(),
                        name: 'Cable Tv',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsComputer.toString(),
                        name: 'Computer',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsDvd.toString(),
                        name: 'DVD',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsGrill.toString(),
                        name: 'Grill',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsHiFi.toString(),
                        name: 'Hi-Fi',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsJuicer.toString(),
                        name: 'Juicer',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsGym.toString(),
                        name: 'Gym',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsBalcony.toString(),
                        name: 'Balcony',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsCleaningAfterExit.toString(),
                        name: 'Cleaning after exit',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsCot.toString(),
                        name: 'Cot',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsFan.toString(),
                        name: 'Fan',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsHairdryer.toString(),
                        name: 'Hairdryer',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsInternet.toString(),
                        name: 'Internet',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsLift.toString(),
                        name: 'Lift',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsFireplace.toString(),
                        name: 'Fireplace',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsBedding.toString(),
                        name: 'Bedding',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsCofeePot.toString(),
                        name: 'Cofee pot',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsDishwasher.toString(),
                        name: 'Dishwasher',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsFridge.toString(),
                        name: 'Fridge',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsHeater.toString(),
                        name: 'Heater',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsIron.toString(),
                        name: 'Iron',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsMicrowave.toString(),
                        name: 'Microwave',
                      ),
                      AmenitiesWidget(
                        isYes: props.propsHotTub.toString(),
                        name: 'Hot Tub',
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Divider(
                  height: 1,
                  color: Colors.black54,
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: HeaderTitle(
                  title: 'FACILITIES',
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    PropertyKeyAndValue(
                      propsKey: 'Shopping Mall',
                      propsValue: props.propsShoppingMall.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Hospital',
                      propsValue: props.propsHospital.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'School',
                      propsValue: props.propsSchool.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Petrol Pump',
                      propsValue: props.propsPetrolPump.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Airport',
                      propsValue: props.propsAirport.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Church ',
                      propsValue: props.propsChurch.toString(),
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Mosque ',
                      propsValue: props.propsMosque.toString(),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Divider(
                  height: 1,
                  color: Colors.black54,
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: HeaderTitle(
                  title: 'VALUATION',
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    PropertyKeyAndValue(
                      propsKey: 'Crime',
                      propsValue: '${props.propsCrime.toString()}%',
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Traffic',
                      propsValue: '${props.propsTraffic.toString()}%',
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Pollution',
                      propsValue: '${props.propsPollution.toString()}%',
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Education',
                      propsValue: '${props.propsEducation.toString()}%',
                    ),
                    PropertyKeyAndValue(
                      propsKey: 'Health',
                      propsValue: '${props.propsHealth.toString()}%',
                    ),
                  ],
                ),
              ),
              (user_status == 'user')
                  ? propertyBtn(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await propsController.requestInspection(
                            user_id, props.propsId, props.propsAgentId);

                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      },
                      title: 'Request For Inspection',
                      bgColor: Colors.blue,
                      isLoading: isLoading,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
