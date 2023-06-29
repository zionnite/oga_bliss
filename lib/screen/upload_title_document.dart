import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/widget/my_text_field.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn.dart';

class UploadTitleDocument extends StatefulWidget {
  const UploadTitleDocument({required this.props_id, required this.user_id});

  final String props_id;
  final String user_id;

  @override
  State<UploadTitleDocument> createState() => _UploadTitleDocumentState();
}

class _UploadTitleDocumentState extends State<UploadTitleDocument> {
  final propsController = PropertyController().getXID;

  TextEditingController docFileNameController = TextEditingController();

  PlatformFile? _doc_file;
  String? _doc_ext;
  Future _getDocFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
      );
      if (result == null) return;

      setState(() {
        _doc_file = result.files.first;
        _doc_ext = _doc_file!.extension;
      });
    } on PlatformException catch (e) {}
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Upload Title Document'),
          Container(
            padding: const EdgeInsets.only(top: 0, left: 8, right: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: docFileNameController,
                  fieldName: 'Document Name',
                  hintName: 'e.g C.F.O, Governor Permit,etc',
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: _getDocFile,
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_open,
                              color: Colors.blue,
                            ),
                            Text(
                              'Select Document',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey.shade200,
                    ),
                    child: Center(
                      child: _doc_file == null
                          ? const Text(
                              'No Document selected',
                              style: TextStyle(fontSize: 20),
                            )
                          : (_doc_ext == 'pdf')
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        'assets/images/pdf.png',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(_doc_file!.name)
                                  ],
                                )
                              : Image.file(
                                  File(_doc_file!.path!),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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

                if (docFileNameController.text != '' && _doc_file != null) {
                  await propsController.uploadTitleDocument(
                    doc_name: docFileNameController.text,
                    doc_file: _doc_file,
                    propsId: widget.props_id,
                    userId: widget.user_id,
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      docFileNameController.text = '';
                      _doc_file = null;
                      isLoading = false;
                    });
                  });
                }
              },
              title: 'Submit',
              bgColor: Colors.blue.shade700,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
