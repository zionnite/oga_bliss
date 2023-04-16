import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'manage_subscription.dart';

class BlissPlan extends StatefulWidget {
  const BlissPlan({Key? key}) : super(key: key);

  @override
  State<BlissPlan> createState() => _BlissPlanState();
}

class _BlissPlanState extends State<BlissPlan> {
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
                      'Your Plan with Bliss Legacy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const ManageSubscription());
                        },
                        child: Column(
                          children: [
                            Card(
                              child: ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/a.jpeg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: const Text(
                                  'EATING COMPETITION',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: const Text(
                                  '23/03/2023',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Card(
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/a.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'EATING COMPETITION',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text(
                                '23/03/2023',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
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
