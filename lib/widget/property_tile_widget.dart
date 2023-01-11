import 'package:flutter/material.dart';

import '../util/currency_formatter.dart';

class PropertyTileWidget extends StatefulWidget {
  PropertyTileWidget({
    required this.props_image_name,
    required this.props_name,
    required this.props_desc,
    required this.props_price,
    required this.props_type,
    required this.props_bedroom,
    required this.props_bathroom,
    required this.props_toilet,
    required this.onTap,
  });

  final String props_image_name;
  final String props_name;
  final String props_desc;
  final String props_price;
  final String props_type;
  final String props_bedroom;
  final String props_bathroom;
  final String props_toilet;
  final VoidCallback onTap;

  @override
  State<PropertyTileWidget> createState() => _PropertyTileWidgetState();
}

class _PropertyTileWidgetState extends State<PropertyTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.props_image_name,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.props_name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Passion One',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 0,
                      ),
                      child: Text(
                        widget.props_desc,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: '',
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            margin: const EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                            ),
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                              bottom: 3,
                              top: 3,
                            ),
                            child: Text(
                              CurrencyFormatter.getCurrencyFormatter(
                                amount: "${widget.props_price}",
                              ),
                              style: const TextStyle(
                                fontFamily: 'BlackOpsOne',
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: (widget.props_type == 'Rent')
                                ? Colors.green[400]
                                : Colors.red[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          margin: const EdgeInsets.only(
                            left: 8.0,
                            top: 8.0,
                          ),
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            bottom: 3,
                            top: 3,
                          ),
                          child: Text(
                            widget.props_type,
                            style: const TextStyle(
                              fontFamily: 'BlackOpsOne',
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: widget.onTap,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert_rounded,
                    size: 17,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 10,
              top: 13,
            ),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}