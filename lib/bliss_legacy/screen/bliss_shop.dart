import 'package:flutter/material.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/clipper_object.dart';
import 'package:oga_bliss/util/currency_formatter.dart';

class BlissShop extends StatefulWidget {
  const BlissShop({Key? key}) : super(key: key);

  @override
  State<BlissShop> createState() => _BlissShopState();
}

class _BlissShopState extends State<BlissShop> {
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      'Shop with Bliss Legacy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  BlissClipperObject(
                    marginVal: 0,
                  ),
                  ListView(
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Column(
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
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/images/a.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'EATING COMPETITION',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('OUTRIGHT Plan'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('1 Invoice Limit'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                            amount: '1000',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(9),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            'Subscribe Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                      ),
                      Column(
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
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/images/a.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'EATING COMPETITION',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('OUTRIGHT Plan'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('1 Invoice Limit'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                            amount: '1000',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(9),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            'Subscribe Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                      ),
                      Column(
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
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/images/a.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'EATING COMPETITION',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('OUTRIGHT Plan'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('1 Invoice Limit'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                            amount: '1000',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(9),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            'Subscribe Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                      ),
                      Column(
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
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/images/a.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'EATING COMPETITION',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('OUTRIGHT Plan'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('1 Invoice Limit'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                            amount: '1000',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(9),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            'Subscribe Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                      ),
                      Column(
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
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/images/a.jpeg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'EATING COMPETITION',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('OUTRIGHT Plan'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text('1 Invoice Limit'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CurrencyFormatter
                                              .getCurrencyFormatter(
                                            amount: '1000',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(9),
                                          color: Colors.blue.shade900,
                                          child: const Text(
                                            'Subscribe Now',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
