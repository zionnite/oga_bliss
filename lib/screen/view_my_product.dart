import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _image, _sliderImg;
  File? imageName;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      File imgName = File(image.name);

      setState(() {
        _image = img;
        imageName = imgName;
      });
    } on PlatformException catch (e) {}
  }

  Future _pickSliderImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      setState(() {
        _sliderImg = img;
      });
    } on PlatformException catch (e) {}
  }

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
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              radius: 5,
                              title: 'Upload Feature Image',
                              content: Column(
                                children: const [
                                  Text(
                                    'We recommend image to be in the following dimension for your property to be approve on our platform.\n\nwidth=1300px By height=450px respectively',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              textConfirm: 'Upload Image',
                              onConfirm: () async {
                                await _pickSliderImage(
                                  ImageSource.gallery,
                                );

                                var status =
                                    await propsController.uploadFeatureImage(
                                  widget.user_id,
                                  model.propsId,
                                  _sliderImg!,
                                  widget.model,
                                );

                                if (status != false) {
                                  setState(() {
                                    int index = propsController.myPropertyList
                                        .indexOf(model);
                                    propsController.myPropertyList[index]
                                        .sliderImg = status;
                                    propsController.myPropertyList.refresh();
                                  });
                                }

                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              textCancel: 'No, later',
                              onCancel: () {},
                            );
                          },
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
                                        'Add Feature Image',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
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
                        child: InkWell(
                          onTap: () {
                            Get.defaultDialog(
                              radius: 5,
                              title: 'Upload Image',
                              content: Column(
                                children: const [
                                  Text(
                                    'We recommend image to be in the following dimension for your property to be approve on our platform.\n\nwidth=800px By height=500px respectively',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              textConfirm: 'Upload Image',
                              onConfirm: () async {
                                await _pickImage(
                                  ImageSource.gallery,
                                );

                                var status = await propsController.uploadImage(
                                  widget.user_id,
                                  model.propsId,
                                  _image!,
                                  widget.model,
                                );

                                if (status != false) {
                                  setState(() {
                                    propsController.imageList.value =
                                        status.cast<GetAllPropsImage>();

                                    int index = propsController.myPropertyList
                                        .indexOf(model);
                                    propsController
                                        .myPropertyList[index].getAllPropsImage!
                                        .addAll(propsController.imageList);
                                    propsController.myPropertyList.refresh();
                                  });
                                }

                                // int rootIndex = imgList!.indexOf(imgList[]);
                                // imgList.removeAt(rootIndex);

                                final rootIndex = imgList!.indexWhere(
                                    (element) =>
                                        element!.propId == model.propsId);
                                if (rootIndex != -1) {
                                  // imgList.add(imageName);
                                  // print("Index $index1: ${people[index1]}");
                                }

                                // print('refresh');
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                // Get.off(
                                //   () => ViewMyProduct(
                                //     model: model,
                                //     user_id: widget.user_id,
                                //   ),
                                // );
                              },
                              textCancel: 'No, later',
                              onCancel: () {},
                            );
                          },
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
                                        'Add Product Image',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Image.network(
                    '${widget.model.sliderImg}',
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/a.jpeg',
                        fit: BoxFit.fitWidth,
                      );
                    },
                    loadingBuilder: (context, Widget child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
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
                                    // print('confirm');
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
