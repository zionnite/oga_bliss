import 'package:flutter/material.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/my_text_field.dart';
import 'package:oga_bliss/widget/property_btn_icon.dart';

class SendEmail extends StatefulWidget {
  SendEmail({
    required this.dis_user_id,
    required this.full_name,
    required this.email,
  });
  final String dis_user_id;
  final String full_name;
  final String email;

  @override
  State<SendEmail> createState() => _SendEmailState();
}

class _SendEmailState extends State<SendEmail> {
  final usersController = UsersController().getXID;

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorPrimary,
        title: const Text('Send Email to User'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
            ),
            child: Column(
              children: [
                MyTextField(
                  myTextFormController: subjectController,
                  fieldName: 'Subject',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: messageController,
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
                    labelText: 'Message',
                    hintText: 'Write Message here',
                  ),
                ),
              ],
            ),
          ),
          PropertyBtnIcon(
            onTap: () async {
              if (subjectController.text != '' &&
                  messageController.text != '') {
                setState(() {
                  isLoading = true;
                });
                bool status = await usersController.sendEmail(
                  disUserId: widget.dis_user_id,
                  fullName: widget.full_name,
                  email: widget.email,
                  subject: subjectController.text,
                  message: messageController.text,
                );

                if (status || !status) {
                  setState(() {
                    isLoading = false;
                    messageController.text = '';
                    subjectController.text = '';
                  });
                }
              }
            },
            title: 'Send Message',
            bgColor: Colors.blue.shade900,
            icon: Icons.send,
            icon_color: Colors.white,
            icon_size: 20,
            isSuffix: true,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
