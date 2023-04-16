import 'package:flutter/material.dart';
import 'package:flutterme_credit_card/flutterme_credit_card.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/currency_formatter.dart';

import '../../widget/property_card.dart';
import 'land_transaction.dart';

class ManageSubscription extends StatefulWidget {
  const ManageSubscription({Key? key}) : super(key: key);

  @override
  State<ManageSubscription> createState() => _ManageSubscriptionState();
}

class _ManageSubscriptionState extends State<ManageSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: InkWell(
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
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      'Your Weekly Plan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FMCreditCard(
                    margin: const EdgeInsets.all(0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade900,
                        Colors.blue,
                      ],
                    ),
                    number: '4084080937644081',
                    numberMaskType: FMMaskType.first6last2,
                    cvv: '***',
                    cvvMaskType: FMMaskType.full,
                    validThru: '03/23',
                    validThruMaskType: FMMaskType.none,
                    holder: 'Nosakhare Zionnite',
                    title: 'Bliss Legacy | Subscription Card',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  BorderRadius.circular(20.0), //<-- SEE HERE
                            ),
                            elevation: 2,
                            color: Colors.blue.shade900,
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
                                  right: 5,
                                  left: 5,
                                ),
                                child: Text(
                                  'Disable Subscription',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  BorderRadius.circular(20.0), //<-- SEE HERE
                            ),
                            elevation: 2,
                            color: Colors.white,
                            child: Container(
                              decoration: const BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.blue.shade900,
                                  // ),

                                  ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 15.0,
                                  right: 5,
                                  left: 5,
                                ),
                                child: Text(
                                  'Update Card',
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  propertyCard(
                    bgColor1: Colors.blue,
                    bgColor2: Colors.blue.shade900,
                    title: 'Total Amount',
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
                    title: 'Number of Successful Debiting',
                    isNaira: false,
                    value: '${0}',
                    icon: const Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  propertyCard(
                    bgColor1: Colors.blue,
                    bgColor2: Colors.blue.shade900,
                    title: 'Number of Failed Debiting',
                    value: '${0}',
                    icon: const Icon(
                      Icons.trending_down,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Card Transaction Activities',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const LandTransaction());
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView(
                        padding: const EdgeInsets.only(top: 0, bottom: 120),
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text(
                                CurrencyFormatter.getCurrencyFormatter(
                                  amount: '2000',
                                ),
                              ),
                              subtitle: const Text(
                                'Card debited for Oka Community Daily Plan',
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
