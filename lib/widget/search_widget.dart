import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/search_page.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchTermContr = TextEditingController();
  String? searchTerm;
  bool showError = false;

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
          child: TextField(
            controller: searchTermContr,
            decoration: const InputDecoration(
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
            onChanged: (val) {
              setState(() {
                searchTerm = searchTermContr.text;
                showError = false;
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        (showError)
            ? const Text(
                'Search Field is empty',
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            : Container(),
        InkWell(
          onTap: () {
            if (searchTerm == null || searchTerm == '') {
              setState(() {
                showError = true;
              });
            } else {
              Get.to(
                () => SearchPage(searchTerm: searchTerm!),
                transition: Transition.leftToRightWithFade,
              );
            }
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
