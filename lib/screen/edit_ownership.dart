import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/property_controller.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:oga_bliss/widget/my_dropdown_field.dart';
import 'package:oga_bliss/widget/my_text_field.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditOwnership extends StatefulWidget {
  EditOwnership({required this.model});

  final PropertyModel model;
  @override
  State<EditOwnership> createState() => _EditOwnershipState();
}

class _EditOwnershipState extends State<EditOwnership> {
  final propsController = PropertyController().getXID;
  int _activeStepIndex = 0;

  String? user_id;
  String? user_status;
  bool? admin_status;

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

  TextEditingController owenerNameController = TextEditingController();
  TextEditingController owenerPhoneController = TextEditingController();
  TextEditingController owenerEmailController = TextEditingController();
  //owner of this property
  final _whoOwnPropertyList = [
    {"value": "no", "name": "No"},
    {"value": "yes", "name": "Yes"},
  ];
  String? props_ownership;

  bool isLoading = false;

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Property Valuation'),
          content: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                MyDropDownField(
                  labelText: 'you owned this property?',
                  value: props_ownership,
                  dropDownList: List.generate(
                    _whoOwnPropertyList.length,
                    (i) => DropdownMenuItem(
                      value: _whoOwnPropertyList[i]["value"],
                      child: Text("${_whoOwnPropertyList[i]["name"]}"),
                    ),
                  ),
                  onChanged: (Object? value) {
                    setState(() {
                      props_ownership = value.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: owenerNameController,
                  fieldName:
                      (props_ownership == 'yes') ? 'Your Name' : 'Agent Name',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: owenerPhoneController,
                  fieldName: (props_ownership == 'yes')
                      ? 'Your Phone Number'
                      : 'Agent Phone Number',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: owenerEmailController,
                  fieldName: (props_ownership == 'yes')
                      ? 'Your Email Address'
                      : 'Agent Email Address',
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Confirm'),
          content: Container(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PropertyAppBar(title: 'Edit Property - Ownership Status'),
            (isLoading)
                ? Center(
                    child: Container(
                      child: LoadingAnimationWidget.inkDrop(
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : OrientationBuilder(
                    builder: (BuildContext context, Orientation orientation) {
                      switch (orientation) {
                        case Orientation.portrait:
                          return _buildStepper(StepperType.vertical);
                        case Orientation.landscape:
                          return _buildStepper(StepperType.horizontal);
                        default:
                          throw UnimplementedError(orientation.toString());
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Stepper _buildStepper(StepperType type) {
    return Stepper(
      physics: const ClampingScrollPhysics(),
      type: StepperType.vertical,
      currentStep: _activeStepIndex,
      steps: stepList(),
      onStepContinue: () async {
        if (_activeStepIndex < (stepList().length - 1)) {
          setState(() {
            _activeStepIndex += 1;
          });
        } else {
          setState(() {
            isLoading = true;
          });
          // print('form its filled');
          bool status = await propsController.editOwnership(
            owner_status: props_ownership ?? "",
            owner_name: owenerNameController.text,
            owner_phone: owenerPhoneController.text,
            owner_email: owenerEmailController.text,
            propsId: widget.model.propsId!,
            user_id: user_id!,
          );

          // if (status) {
          setState(() {
            isLoading = false;
          });
          // }

          // print('form selected == ${selectedPref}');
          // print('Submited');
        }
      },
      onStepCancel: () {
        if (_activeStepIndex == 0) {
          return;
        }

        setState(() {
          _activeStepIndex -= 1;
        });
      },
      onStepTapped: (int index) {
        setState(() {
          _activeStepIndex = index;
        });
      },
      controlsBuilder: (context, ControlsDetails) {
        final isLastStep = _activeStepIndex == stepList().length - 1;
        return Container(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: ControlsDetails.onStepContinue,
                  child:
                      (isLastStep) ? const Text('Submit') : const Text('Next'),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (_activeStepIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: ControlsDetails.onStepCancel,
                    child: const Text('Back'),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
