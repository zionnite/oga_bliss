import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/home_page.dart';

import '../../widget/my_textfield_icon.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  SignupPage({required this.usersType});

  final String usersType;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final usersController = UsersController().getXID;

  final userNameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image(
              image: const AssetImage('assets/images/login_img.png'),
              height: height * 0.5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                'Create an Account!',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Passion One',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextFieldIcon(
                      myTextFormController: userNameController,
                      fieldName: 'User Name',
                      prefix: Icons.person,
                    ),
                    const Text(
                      'Username must not contain special character or space',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFieldIcon(
                      myTextFormController: fullnameController,
                      fieldName: 'Full Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFieldIcon(
                      myTextFormController: emailController,
                      fieldName: 'Email',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFieldIcon(
                      myTextFormController: phoneController,
                      fieldName: 'Phone No',
                      prefix: Icons.phone_android_sharp,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyTextFieldIcon(
                      myTextFormController: passwordController,
                      fieldName: 'Password',
                      prefix: Icons.key_sharp,
                      suffix: Icons.remove_red_eye,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.off(() => const LoginPage());
                        },
                        child: const Text('Already have Account?'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(),
                          side: const BorderSide(color: Colors.white),
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        onPressed: () async {
                          if (userNameController.text != '' &&
                              fullnameController.text != '' &&
                              emailController.text != '' &&
                              phoneController.text != '' &&
                              passwordController.text != '') {
                            setState(() {
                              isLoading = true;
                            });
                            bool status = await usersController.signUp(
                              userName: userNameController.text,
                              fullName: fullnameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              usersType: widget.usersType,
                            );

                            if (status) {
                              setState(() {
                                userNameController.text = '';
                                fullnameController.text = '';
                                emailController.text = '';
                                phoneController.text = '';
                                passwordController.text = '';
                                isLoading = false;
                              });

                              Get.offAll(() => const HomePage());
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: (isLoading)
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.white,
                                size: 20,
                              ))
                            : const Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
