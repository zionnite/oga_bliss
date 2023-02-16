import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeMe extends StatefulWidget {
  NoticeMe({
    required this.title,
    required this.desc,
    required this.icon,
    required this.icon_color,
    required this.border_color,
    required this.btnTitle,
    required this.btnColor,
    required this.onTap,
  });

  final String title;
  final String desc;
  final IconData icon;
  final Color icon_color;
  final Color border_color;
  final String btnTitle;
  final Color btnColor;
  final VoidCallback onTap;
  @override
  State<NoticeMe> createState() => _NoticeMeState();
}

class _NoticeMeState extends State<NoticeMe> {
  final usersController = UsersController().getXID;

  String? user_id;
  String? user_status;
  bool? admin_status;

  String? full_name;
  String? phone;
  String? email;
  String? age;
  String? sex;

  String? accountName;
  String? accountNum;
  String? bankName;
  String? bankCode;

  String? image_name;
  String? isbank_verify;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    var phone1 = prefs.getString('phone');
    var email1 = prefs.getString('email');
    var age1 = prefs.getString('age');
    var sex1 = prefs.getString('sex');
    var account_name1 = prefs.getString('account_name');
    var account_number1 = prefs.getString('account_number');
    var bank_name1 = prefs.getString('bank_name');
    var image_name1 = prefs.getString('image_name');
    var isbank_verify1 = prefs.getString('isbank_verify');
    var fullName1 = prefs.getString('full_name');
    var bankCode1 = prefs.getString('bank_code');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        phone = phone1;
        email = email1;
        age = age1;
        sex = sex1;
        accountName = account_name1;
        accountNum = account_number1;
        bankName = bank_name1;
        image_name = image_name1;
        isbank_verify = isbank_verify1;
        full_name = fullName1!;
        bankCode = bankCode1;
      });
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('bank code $isbank_verify');
    return (isbank_verify == 'yes')
        ? Container()
        : Card(
            elevation: 2,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5,
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: widget.border_color,
                      width: 5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widget.icon,
                          color: Colors.red,
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.desc,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        bool status = await usersController.verifyBank(
                          accountNum: accountNum!,
                          bankCode: bankCode!,
                          my_id: user_id!,
                        );

                        if (status || !status) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        if (status) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('isbank_verify', 'yes');

                          setState(() {
                            isbank_verify = 'yes';
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            widget.btnTitle,
                            style: TextStyle(
                              color: widget.btnColor,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          (isLoading)
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.blue,
                                    size: 20,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
