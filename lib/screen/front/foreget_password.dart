import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/home_page.dart';
import 'package:oga_bliss/screen/front/login_page.dart';

import '../../widget/my_textfield_icon.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForetPasswordPageState();
}

class _ForetPasswordPageState extends State<ForgetPasswordPage> {
  final usersController = UsersController().getXID;
  final emailController = TextEditingController();
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
                'Change Password',
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
                children: [
                  MyTextFieldIcon(
                    myTextFormController: emailController,
                    fieldName: 'Email',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const LoginPage());
                      },
                      child: const Text('Already have account?'),
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
                        if (emailController.text != '') {
                          setState(() {
                            isLoading = true;
                          });
                          bool status = await usersController.resetPassword(
                            email: emailController.text,
                          );
                          if (status) {
                            setState(() {
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
                              'Reset Password',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
