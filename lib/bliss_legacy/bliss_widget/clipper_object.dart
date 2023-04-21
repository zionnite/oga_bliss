import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/customer_clipper.dart';
import 'package:oga_bliss/bliss_legacy/screen/shop_plan_type.dart';

class BlissClipperObject extends StatefulWidget {
  BlissClipperObject({this.marginVal = 188.0, this.isSelected = false});
  final double marginVal;
  final bool isSelected;

  @override
  State<BlissClipperObject> createState() => _BlissClipperObjectState();
}

class _BlissClipperObjectState extends State<BlissClipperObject> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.marginVal),
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    () => ShopPlanType(
                      planId: 'building',
                    ),
                  );
                },
                child: BlissCustomClipper(
                  name: 'Building Plan',
                  isSelected: widget.isSelected,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => ShopPlanType(
                      planId: 'land',
                    ),
                  );
                },
                child: BlissCustomClipper(
                  name: 'Lands Plan',
                  isSelected: widget.isSelected,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => ShopPlanType(
                      planId: 'daily',
                    ),
                  );
                },
                child: BlissCustomClipper(
                  name: 'Daily Plan',
                  isSelected: widget.isSelected,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => ShopPlanType(
                      planId: 'weekly',
                    ),
                  );
                },
                child: BlissCustomClipper(
                  name: 'Weekly Plan',
                  isSelected: widget.isSelected,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => ShopPlanType(
                      planId: 'monthly',
                    ),
                  );
                },
                child: BlissCustomClipper(
                  name: 'Monthly Plan',
                  isSelected: widget.isSelected,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
