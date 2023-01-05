import 'package:flutter/material.dart';

class AllPropertyPage extends StatefulWidget {
  const AllPropertyPage({Key? key}) : super(key: key);

  @override
  State<AllPropertyPage> createState() => _AllPropertyPageState();
}

class _AllPropertyPageState extends State<AllPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 450,
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 39,
                    ),
                    onPressed: () {
                      print('hello');
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Find Your Dream',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Passion One',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lobster',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5, top: 15),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.black87,
                            ),
                            hintText: "Search you're looking for",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text('Find Now'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 320,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, right: 8.0, left: 8.0, bottom: 100),
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  // itemExtent: 350,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Property Name',
                                    style: TextStyle(
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'NGN 5,000',
                                      style: TextStyle(
                                        fontFamily: 'BlackOpsOne',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //Rooms, toilet etc
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Icon(Icons.bed_sharp),
                                            Text(
                                              '4 Bedroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.bathtub_rounded),
                                            Text(
                                              '4 Bathroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.event_seat_outlined),
                                            Text(
                                              '4 Toilet',
                                              style: TextStyle(
                                                fontSize: 14,
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
                                trailing: const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
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
                              children: const [
                                Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '/4',
                                  style: TextStyle(
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
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Property Name',
                                    style: TextStyle(
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'NGN 5,000',
                                      style: TextStyle(
                                        fontFamily: 'BlackOpsOne',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //Rooms, toilet etc
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Icon(Icons.bed_sharp),
                                            Text(
                                              '4 Bedroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.bathtub_rounded),
                                            Text(
                                              '4 Bathroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.event_seat_outlined),
                                            Text(
                                              '4 Toilet',
                                              style: TextStyle(
                                                fontSize: 14,
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
                                trailing: const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
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
                              children: const [
                                Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '/4',
                                  style: TextStyle(
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
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Property Name',
                                    style: TextStyle(
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'NGN 5,000',
                                      style: TextStyle(
                                        fontFamily: 'BlackOpsOne',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //Rooms, toilet etc
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Icon(Icons.bed_sharp),
                                            Text(
                                              '4 Bedroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.bathtub_rounded),
                                            Text(
                                              '4 Bathroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.event_seat_outlined),
                                            Text(
                                              '4 Toilet',
                                              style: TextStyle(
                                                fontSize: 14,
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
                                trailing: const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
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
                              children: const [
                                Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '/4',
                                  style: TextStyle(
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
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Property Name',
                                    style: TextStyle(
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'NGN 5,000',
                                      style: TextStyle(
                                        fontFamily: 'BlackOpsOne',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //Rooms, toilet etc
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Icon(Icons.bed_sharp),
                                            Text(
                                              '4 Bedroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.bathtub_rounded),
                                            Text(
                                              '4 Bathroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.event_seat_outlined),
                                            Text(
                                              '4 Toilet',
                                              style: TextStyle(
                                                fontSize: 14,
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
                                trailing: const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
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
                              children: const [
                                Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '/4',
                                  style: TextStyle(
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
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                              ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Property Name',
                                    style: TextStyle(
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
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'NGN 5,000',
                                      style: TextStyle(
                                        fontFamily: 'BlackOpsOne',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //Rooms, toilet etc
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Icon(Icons.bed_sharp),
                                            Text(
                                              '4 Bedroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.bathtub_rounded),
                                            Text(
                                              '4 Bathroom',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.event_seat_outlined),
                                            Text(
                                              '4 Toilet',
                                              style: TextStyle(
                                                fontSize: 14,
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
                                trailing: const Icon(
                                  Icons.favorite_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
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
                              children: const [
                                Icon(
                                  Icons.camera_enhance_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  '/4',
                                  style: TextStyle(
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
