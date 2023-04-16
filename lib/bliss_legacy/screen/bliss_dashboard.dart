import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/clipper_object.dart';

import '../../util/currency_formatter.dart';
import 'land_transaction.dart';

class BlissDashboard extends StatefulWidget {
  const BlissDashboard({Key? key}) : super(key: key);

  @override
  State<BlissDashboard> createState() => _BlissDashboardState();
}

class _BlissDashboardState extends State<BlissDashboard> {
  List RandomImages = [
    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/a.jpeg'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Zionnite,',
                        style: TextStyle(
                            // fontSize: 15,
                            ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Payable Balance:',
                            style: TextStyle(
                              // fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          shortenMoney('1000000000'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0.0, 10.0),
                              blurRadius: 20.0,
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset.centerLeft,
                        child: const Image(
                          image: AssetImage(
                            'assets/images/bank_note.png',
                          ),
                          height: 200,
                          width: 190,
                          // color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 0, bottom: 2, right: 10),
                              child: Text(
                                'Start Investing In Real Estate Today',
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'BlackOpsOne',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 10),
                              child: Container(
                                height: 40.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue.shade900,
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                                child: Center(
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Start Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                            Icons.chevron_right_outlined,
                                            color: Colors.white,
                                          ),
                                          alignment:
                                              PlaceholderAlignment.middle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlissClipperObject(),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Downline',
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
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        // parent row
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0; i < RandomImages.length; i++)
                              Align(
                                widthFactor: 0.8,
                                // parent circle avatar.
                                // We defined this for better UI
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue.shade900,
                                  // Child circle avatar
                                  child: CircleAvatar(
                                    radius: 38,
                                    backgroundImage:
                                        NetworkImage(RandomImages[i]),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
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
                            'Recent Transaction',
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

shortenMoney(String amount) {
  if (amount.length <= 2) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 3) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 5) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 7) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 45,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 9) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  }
}
