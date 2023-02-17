import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/home_page.dart';

import '../../widget/my_textfield_icon.dart';
import 'decide_page.dart';
import 'foreget_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usersController = UsersController().getXID;

  final emailController = TextEditingController();
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
                'Login',
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
                          Get.to(() => const ForgetPasswordPage());
                        },
                        child: const Text('forget Password?'),
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
                          if (emailController.text != '' &&
                              passwordController.text != '') {
                            setState(() {
                              isLoading = true;
                            });
                            bool status = await usersController.login(
                                email: emailController.text,
                                password: passwordController.text);
                            if (status) {
                              setState(() {
                                isLoading = false;
                              });

                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // var tempLoginStatus =
                              //     prefs.getBool("tempLoginStatus");
                              //
                              // if (tempLoginStatus == true) {
                              //   var user_id = prefs.getString('user_id');
                              //   var admin_status =
                              //       prefs.getBool('admin_status');
                              //   var user_status =
                              //       prefs.getString('user_status');
                              // }

                              // redirectController.getAllControllers();

                              // RestartWidget.restartApp(context);
                              //
                              // // Phoenix.rebirth(context);
                              // Get.put(SplashController());
                              // Get.put(OnboardingCongroller());
                              // Get.put(PropertyController());
                              // Get.put(FavouriteController());
                              // Get.put(RequestController());
                              // Get.put(ConnectionController());
                              // Get.put(TransactionController());
                              // Get.put(AlertController());
                              // Get.put(ChatHeadController());
                              // Get.put(WalletController());
                              // Get.put(UsersController());
                              // Get.put(DashboardController());
                              // Get.put(RedirectController());

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
                                'Login',
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const DecidePage());
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Don\'t have account?, click here',
                    style: TextStyle(
                      color: Colors.red.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
