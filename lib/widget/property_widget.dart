import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/property_detailed_page.dart';
import '../util/currency_formatter.dart';

class PropertyWidget extends StatefulWidget {
  PropertyWidget({
    required this.props_image,
    required this.props_name,
    required this.props_type,
    required this.props_price,
    required this.isFav,
    required this.props_bedroom,
    required this.props_bathroom,
    required this.props_toilet,
    required this.props_image_counter,
  });

  String props_image;
  String props_name;
  String props_type;
  String props_price;
  bool isFav;
  String props_bedroom;
  String props_bathroom;
  String props_toilet;
  String props_image_counter;

  @override
  State<PropertyWidget> createState() => _PropertyWidgetState();
}

class _PropertyWidgetState extends State<PropertyWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const PropertyDetailPage());
      },
      child: Stack(
        children: [
          Card(
            elevation: 5,
            child: Column(
              children: [
                Image.network(
                  widget.props_image,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.props_name,
                      style: const TextStyle(
                        fontFamily: 'Passion One',
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          color: (widget.props_type == "buy")
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          widget.props_type,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        CurrencyFormatter.getCurrencyFormatter(
                          amount: "${widget.props_price}",
                        ),
                        style: const TextStyle(
                          fontFamily: 'BlackOpsOne',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Rooms, toilet etc
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.bed_sharp,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.props_bedroom} Bedroom',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.bathtub_rounded,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.props_bathroom} Bathroom',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.event_seat_outlined,
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${widget.props_toilet} Toilet',
                                style: const TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  trailing: (widget.isFav)
                      ? const Icon(
                          Icons.favorite_outlined,
                          color: Colors.blue,
                        )
                      : const Icon(
                          Icons.favorite_outlined,
                          color: Colors.black38,
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: [0.1, 0.9],
                  colors: [
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.4)
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    '/${widget.props_image_counter}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}