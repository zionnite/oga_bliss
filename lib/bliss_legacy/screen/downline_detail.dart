import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/bliss_downline_model.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/rounded_button.dart';
import 'package:oga_bliss/bliss_legacy/screen/view_user_downline.dart';
import 'package:oga_bliss/bliss_legacy/screen/view_user_plan_list.dart';
import 'package:oga_bliss/widget/property_card.dart';
import 'package:oga_bliss/widget/property_key.dart';

class DownlineDetail extends StatefulWidget {
  DownlineDetail({required this.data});

  final User data;

  @override
  State<DownlineDetail> createState() => _DownlineDetailState();
}

class _DownlineDetailState extends State<DownlineDetail> {
  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                      image: AssetImage('assets/images/a.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(35),
                          ),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 225,
                  left: 140,
                  child: CircleAvatar(
                    radius: 55,
                    child: CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage('${data.agentImageName}'),
                    ),
                  ),
                ),
              ],
            ),
            Card(
              elevation: 1,
              margin: const EdgeInsets.only(
                top: 70,
                left: 10,
                right: 10,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40, left: 15),
                      child: const Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Passion One',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PropertyKey(
                      propsKey: data.agentFullName!,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(height: 1, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 15),
                      child: const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Passion One',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PropertyKey(
                      propsKey: data.agentPhone!,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
              child: Row(
                children: [
                  RoundedButton(
                    bgColor: Colors.blue.shade900,
                    txtColor: Colors.white,
                    title: 'View Downline',
                    onTap: () {
                      Get.to(
                        () => ViewUserDownline(
                          downlineData: data,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RoundedButton(
                    bgColor: Colors.white,
                    txtColor: Colors.blue,
                    title: 'Plan List',
                    onTap: () {
                      Get.to(
                        () => ViewUserPlanList(
                          disUserId: data.agentId!,
                          disUserFullName: data.agentFullName!,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            propertyCard(
              bgColor1: Colors.blue,
              bgColor2: Colors.blue.shade900,
              title: 'Total Amount Earned',
              value: '${0}',
              icon: const Icon(
                Icons.wallet,
                color: Colors.white,
                size: 30,
              ),
            ),
            propertyCard(
              bgColor1: Colors.blue,
              bgColor2: Colors.blue.shade900,
              title: 'Downline',
              isNaira: false,
              value: '${data.countDownline}',
              icon: const Icon(
                Icons.people_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            propertyCard(
              bgColor1: Colors.blue,
              bgColor2: Colors.blue.shade900,
              isNaira: false,
              title: 'Number of Subscription',
              value: '${data.countSub}',
              icon: const Icon(
                Icons.account_tree_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
