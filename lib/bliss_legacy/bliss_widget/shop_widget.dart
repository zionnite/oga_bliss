import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../util/currency_formatter.dart';

class shopWidget extends StatefulWidget {
  shopWidget({
    required this.planImg,
    required this.planName,
    required this.planInterval,
    required this.planLimit,
    required this.planAmount,
    required this.onTap,
    this.isLoading = false,
    required this.isSubscribe,
    this.item = -1,
    this.selectedItem = -1,
  });

  final String planImg;
  final String planName;
  final String planInterval;
  final String planLimit;
  final String planAmount;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isSubscribe;
  final int item;
  final int selectedItem;

  @override
  State<shopWidget> createState() => _shopWidgetState();
}

class _shopWidgetState extends State<shopWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(0),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.planImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.planName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(widget.planInterval),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Invoice Limit: ${widget.planLimit}'),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        CurrencyFormatter.getCurrencyFormatter(
                          amount: widget.planAmount,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      (widget.isSubscribe)
                          ? Container(
                              padding: const EdgeInsets.all(9),
                              color: Colors.blueAccent,
                              child: const Text(
                                'Subscribed',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: widget.onTap,
                              child: Container(
                                padding: const EdgeInsets.all(9),
                                color: Colors.blue.shade900,
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Subscribe Now',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    (widget.isLoading &&
                                            widget.item == widget.selectedItem)
                                        ? Center(
                                            child: LoadingAnimationWidget
                                                .staggeredDotsWave(
                                              color: Colors.white,
                                              size: 13,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
