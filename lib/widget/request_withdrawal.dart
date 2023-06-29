import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/controller/withdrawal_controller.dart';
import 'package:oga_bliss/widget/my_money_field.dart';
import 'package:oga_bliss/widget/notice_me.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestWithdrawal extends StatefulWidget {
  const RequestWithdrawal({Key? key}) : super(key: key);

  @override
  State<RequestWithdrawal> createState() => _RequestWithdrawalState();
}

class _RequestWithdrawalState extends State<RequestWithdrawal> {
  final usersController = UsersController().getXID;
  final withdrawalController = WithdrawalController().getXID;
  TextEditingController amountController = TextEditingController();

  final String NGN = cSymbol("NGN");
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  String disAmount = "0";
  String disString = '';
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
    return Scaffold(
        body: Column(
      children: [
        const PropertyAppBar(title: 'Request Withdrawal'),
        (isbank_verify == 'no')
            ? NoticeMe(
                title: 'Oops!',
                desc:
                    'Your bank account is not yet verify.\n\nYou have to verify your Bank Account in other to make a Withdrawal Request.!',
                icon: Icons.warning,
                icon_color: Colors.red,
                border_color: Colors.red,
                btnTitle: 'Verify Now',
                btnColor: Colors.blue,
                onTap: () {},
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 8.0,
                    ),
                    child: MyMoneyField(
                      myTextFormController: amountController,
                      fieldName: 'Amount',
                      prefix: Icons.attach_money,
                      onChange: (string) {
                        setState(() {
                          disString = string;
                        });
                        if (amountController.text.isNotEmpty) {
                          string =
                              '${_formatNumber(string.replaceAll(',', ''))}';
                          amountController.value = TextEditingValue(
                            text: string,
                            selection:
                                TextSelection.collapsed(offset: string.length),
                          );
                        } else {
                          setState(() {
                            string = '0';
                          });
                        }
                        setState(() {
                          disAmount = string;
                        });
                      },
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
                        await withdrawalController.requestWithdrawal(
                          amount: amountController.text,
                          userId: user_id!,
                        );

                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            amountController.text = '';

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
      ],
    ));
  }
}
