import 'package:flutter/material.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/widget/my_text_field_num.dart';
import 'package:oga_bliss/widget/my_textfield_icon.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn.dart';

class BookSpecification extends StatefulWidget {
  const BookSpecification({Key? key}) : super(key: key);

  @override
  State<BookSpecification> createState() => _BookSpecificationState();
}

class _BookSpecificationState extends State<BookSpecification> {
  final propsController = PropertyController().getXID;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController budFromController = TextEditingController();
  TextEditingController budToController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const PropertyAppBar(title: 'Book Inspection'),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Don\'t worry Bliss Legacy got you covered, Kindly tell us your specifications.',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFieldIcon(
                  myTextFormController: fullNameController,
                  fieldName: 'Full Name',
                  prefix: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: phoneController,
                  fieldName: 'Phone Number',
                  prefix: Icons.phone_android_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    labelText: 'Description',
                    hintText:
                        'Write in details about the kind of Property you want',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: locationController,
                  fieldName: 'Location',
                  prefix: Icons.phone_android_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: areaController,
                  fieldName: 'Area',
                  prefix: Icons.phone_android_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: budFromController,
                  fieldName: 'Budget From',
                  prefix: Icons.monetization_on,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: budToController,
                  fieldName: 'Budget To',
                  prefix: Icons.monetization_on,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: propertyBtn(
              card_margin: EdgeInsets.only(top: 12, left: 8, right: 8),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await propsController.makeRequestSpecification(
                  name: fullNameController.text,
                  phone: phoneController.text,
                  desc: descController.text,
                  location: locationController.text,
                  area: areaController.text,
                  budFrom: budFromController.text,
                  budTo: budToController.text,
                );

                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    fullNameController.text = '';
                    phoneController.text = '';
                    descController.text = '';
                    locationController.text = '';
                    areaController.text = '';
                    budFromController.text = '';
                    budToController.text = '';
                    isLoading = false;
                  });
                });
              },
              title: 'Submit',
              bgColor: Colors.blue.shade700,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    ));
  }
}
