import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/property_controller.dart';
import '../model/property_model.dart';
import '../widget/property_app_bar.dart';

class ViewMyProduct extends StatefulWidget {
  const ViewMyProduct({required this.model, required this.user_id});

  final PropertyModel model;
  final String user_id;

  @override
  State<ViewMyProduct> createState() => _ViewMyProductState();
}

class _ViewMyProductState extends State<ViewMyProduct> {
  final propsController = PropertyController().getXID;

  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var imgList = widget.model.getAllPropsImage;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PropertyAppBar(title: 'Property Image'),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              border: Border.all(
                                color: Colors.blue,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Add Feature Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                          top: 10,
                        ),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              border: Border.all(
                                color: Colors.blue,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Add Image',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image.asset(
                    '${widget.model.sliderImg}',
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Images',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'BlackOpsOne',
                      ),
                    ),
                  ),
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: imgList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      '${imgList[index]!.imageName}',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  radius: 5,
                                  title: 'Delete',
                                  middleText:
                                      'Are you sure you want to Delete this Image',
                                  textConfirm: 'Yes',
                                  onConfirm: () async {
                                    print('confirm');
                                    bool status =
                                        await propsController.deleteProps(
                                      widget.user_id,
                                      model.propsId,
                                      imgList[index]!.id,
                                    );

                                    if (status) {
                                      setState(() {
                                        int rootIndex =
                                            imgList.indexOf(imgList[index]);
                                        imgList.removeAt(rootIndex);
                                      });
                                    }
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  textCancel: 'No',
                                  onCancel: () {},
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
