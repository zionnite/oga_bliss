import 'package:flutter/material.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:oga_bliss/widget/my_textfield_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/banklist_model.dart';
import '../widget/property_btn.dart';

class VerifyBank extends StatefulWidget {
  const VerifyBank({Key? key}) : super(key: key);

  @override
  State<VerifyBank> createState() => _VerifyBankState();
}

class _VerifyBankState extends State<VerifyBank> {
  final usersController = UsersController().getXID;

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumController = TextEditingController();
  bool isLoading = false;

  List<BankList> bankList = [];
  String? bankName;

  populateDropDown() async {
    BankModel data = await ApiServices.getBankList();
    setState(() {
      bankList = data.bankList!;
    });
  }

  String? user_id;
  String? user_status;
  bool? admin_status;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    bool? isNew = prefs.getBool('isNew');

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
    populateDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bank Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MyTextFieldIcon(
                    myTextFormController: accountNameController,
                    fieldName: 'Account Name',
                    prefix: Icons.food_bank,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextFieldIcon(
                    myTextFormController: accountNumController,
                    fieldName: 'Account Number',
                    prefix: Icons.food_bank,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.food_bank),
                      labelText: 'Bank Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white30,
                    ),
                    isExpanded: true,
                    value: bankName,
                    items: bankList
                        .map((e) => DropdownMenuItem(
                              value: e.bankCode,
                              child: Text(e.bankName.toString()),
                            ))
                        .toList(),
                    onChanged: (Object? val) {
                      setState(() {
                        bankName = val.toString();
                      });
                    },
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
                  bool status = await usersController.updateUserBank(
                    accountName: accountNameController.text,
                    accountNum: accountNumController.text,
                    bankName: bankName!,
                    my_id: user_id!,
                  );
                  if (status || !status) {
                    setState(() {
                      isLoading = false;
                    });

                    if (status) {
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          accountNameController.text = '';
                          accountNumController.text = '';
                          bankName = null;
                        });
                      });
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
