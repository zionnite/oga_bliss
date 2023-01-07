import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/search_page.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
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
        InkWell(
          onTap: () {
            Get.to(
              () => const SearchPage(),
              transition: Transition.leftToRightWithFade,
            );
          },
          child: Card(
            elevation: 5,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15,
                  right: 25,
                  left: 25,
                ),
                child: Text('Find Now'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
