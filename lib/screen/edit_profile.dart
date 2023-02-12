import 'package:flutter/material.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/widget/my_dropdown_field.dart';
import 'package:oga_bliss/widget/my_text_field_num.dart';
import 'package:oga_bliss/widget/my_textfield_icon.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final usersController = UsersController().getXID;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  String? user_id;
  String? user_status;
  bool? admin_status;
  String? sex;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  final _genderSelected = [
    {"value": "male", "name": "Male"},
    {"value": "female", "name": "Female"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Column(
                children: [
                  MyTextFieldIcon(
                    myTextFormController: fullNameController,
                    fieldName: 'Full Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFieldIcon(
                    myTextFormController: emailController,
                    fieldName: 'Email Address',
                    prefix: Icons.email,
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
                  MyNumField(
                    myTextFormController: ageController,
                    fieldName: 'Age',
                    prefix: Icons.star_sharp,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyDropDownField(
                    prefix: Icons.accessibility_new,
                    labelText: 'Property Purpose',
                    value: sex,
                    dropDownList: List.generate(
                      _genderSelected.length,
                      (i) => DropdownMenuItem(
                        value: _genderSelected[i]["value"],
                        child: Text("${_genderSelected[i]["name"]}"),
                      ),
                    ),
                    onChanged: (Object? value) {
                      setState(() {
                        sex = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addressController,
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
                      labelText: 'Address',
                      hintText: 'Write Address here',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: propertyBtn(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  bool status = await usersController.updateUserBio(
                    fullName: fullNameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    age: ageController.text,
                    address: addressController.text,
                    sex: sex!,
                    my_id: user_id!,
                  );
                  if (status || !status) {
                    setState(() {
                      isLoading = false;
                    });

                    if (status) {
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          fullNameController.text = '';
                          emailController.text = '';
                          phoneController.text = '';
                          ageController.text = '';
                          addressController.text = '';
                          sex = null;
                        });
                      });

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('isbank_verify', 'no');
                    }
                  }
                },
                title: 'Submit',
                bgColor: Colors.blue.shade700,
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
