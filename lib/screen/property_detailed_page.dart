import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/header_title.dart';
import 'package:popup_banner/popup_banner.dart';

import '../widget/property_key_and_value.dart';

class PropertyDetailPage extends StatefulWidget {
  const PropertyDetailPage({Key? key}) : super(key: key);

  @override
  State<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage> {
  late FlutterYoutubeViewController _controller;
  YoutubeScaleMode _mode = YoutubeScaleMode.none;

  List<String> images = [
    "https://tinyurl.com/popup-banner-image",
    "https://tinyurl.com/popup-banner-image2",
    "https://tinyurl.com/popup-banner-image3",
    "https://tinyurl.com/popup-banner-image4"
  ];

  void showPropertyImage() {
    PopupBanner(
      context: context,
      images: images,
      dotsAlignment: Alignment.bottomCenter,
      dotsColorActive: Colors.blue,
      dotsColorInactive: Colors.grey.withOpacity(0.5),
      onClick: (index) {
        debugPrint("CLICKED $index");
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
                  params: const YoutubeParam(
                    videoId: 'gcj2RUWQZ60',
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Image.network(
                      'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
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
                    Positioned(
                      top: 60,
                      right: 15,
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
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            left: 25,
                            right: 25,
                            top: 5,
                            bottom: 5,
                          ),
                          color: Colors.red[900],
                          child: const Text(
                            'Buy',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 15,
                          ),
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 5,
                            bottom: 5,
                          ),
                          color: Colors.lightGreen[900],
                          child: Text(
                            CurrencyFormatter.getCurrencyFormatter(
                              amount: "${400000000}",
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'BlackOpsOne',
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
                  child: const Text(
                    'Property Name',
                    style: TextStyle(
                      fontSize: 25,
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
                  child: const Text(
                    'Property Description',
                    style: TextStyle(
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
                    '-CONDITION-',
                    style: TextStyle(
                      fontSize: 25,
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
                  child: const Text(
                    'Property Description',
                    style: TextStyle(
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
                    '-SPECIAL PREFERENCE-',
                    style: TextStyle(
                      fontSize: 25,
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
                  child: const Text(
                    'Property Description',
                    style: TextStyle(
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
                  children: const [
                    propertyKeyAndValue(
                      propsKey: 'Type',
                      propsValue: 'Flat/Apartment',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Sub-Type',
                      propsValue: 'Workstation',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Purpose',
                      propsValue: 'Rent',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Status',
                      propsValue: 'Available',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Bedrooms',
                      propsValue: '3 Bedroms',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Bathrooms',
                      propsValue: '5 Bathroom',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Toilets',
                      propsValue: '5 Toilet',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Year Built',
                      propsValue: '2022',
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
                child: Column(
                  children: const [
                    propertyKeyAndValue(
                      propsKey: 'Air conditioning',
                      propsValue: '',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Cable TV',
                      propsValue: '',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Computer',
                      propsValue: '',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'DVD',
                      propsValue: '',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Grill',
                      propsValue: '',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Hi-fi',
                      propsValue: '',
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
                  title: 'FACILITIES',
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: const [
                    propertyKeyAndValue(
                      propsKey: 'Shopping Mall',
                      propsValue: '30 KM',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Hospital',
                      propsValue: '30 KM',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'School',
                      propsValue: '20 mins',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Petrol Pump',
                      propsValue: '3hrs',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Airport',
                      propsValue: '2 Km',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Church ',
                      propsValue: '2 Km',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Mosque ',
                      propsValue: '200 Hrs',
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
                  children: const [
                    propertyKeyAndValue(
                      propsKey: 'Crime',
                      propsValue: '10%',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Traffic',
                      propsValue: '30%',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Pollution',
                      propsValue: '3%',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Education',
                      propsValue: '76%',
                    ),
                    propertyKeyAndValue(
                      propsKey: 'Health',
                      propsValue: '51%',
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Request for Inspection');
                },
                child: Card(
                  color: Colors.blue,
                  margin: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 40,
                    top: 20,
                  ),
                  elevation: 10,
                  child: Ink(
                    color: Colors.blue,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                        top: 10,
                      ),
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Request For Inspection',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Passion One',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
