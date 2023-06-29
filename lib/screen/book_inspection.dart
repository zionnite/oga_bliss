import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/my_text_field_num.dart';
import 'package:oga_bliss/widget/my_textfield_icon.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn.dart';

class BookInspection extends StatefulWidget {
  BookInspection({required this.props_id, required this.agent_id});

  final String props_id;
  final String agent_id;

  @override
  State<BookInspection> createState() => _BookInspectionState();
}

class _BookInspectionState extends State<BookInspection> {
  final propsController = PropertyController().getXID;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");
  var selectedDate, selectedTime;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PropertyAppBar(title: 'Book Inspection'),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  DateTimeField(
                    format: format,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    onChanged: (val) {
                      setState(() {
                        selectedDate = val;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      labelText: 'Date',
                      hintText: 'Select Date',
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DateTimeField(
                    format: timeFormat,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now(),
                        ),
                      );
                      return DateTimeField.convert(time);
                    },
                    onChanged: (val) {
                      setState(() {
                        selectedTime = val;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      labelText: 'Date',
                      hintText: 'Select Date',
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Inspection fee:' +
                        CurrencyFormatter.getCurrencyFormatter(
                          amount: "5000",
                        ),
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
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
                  await propsController.makeRequestInspection(
                    name: fullNameController.text,
                    phone: phoneController.text,
                    date: selectedDate.toString(),
                    time: selectedTime.toString(),
                    propsId: widget.props_id,
                    agentId: widget.agent_id,
                  );

                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      fullNameController.text = '';
                      phoneController.text = '';
                      selectedDate = '';
                      selectedTime = '';

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
      ),
    );
  }
}
