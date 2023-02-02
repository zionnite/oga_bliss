import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/model/property_model.dart';

import '../controller/property_controller.dart';
import '../model/property_type_model.dart';
import '../model/state_model.dart';
import '../services/api_services.dart';
import '../widget/my_raidio_field.dart';
import '../widget/my_text_field.dart';
import '../widget/property_app_bar.dart';

class EditExtraDetail extends StatefulWidget {
  EditExtraDetail({required this.model});

  final PropertyModel model;

  @override
  State<EditExtraDetail> createState() => _EditExtraDetailState();
}

class _EditExtraDetailState extends State<EditExtraDetail> {
  final propsController = PropertyController().getXID;

  int _activeStepIndex = 0;

  TextEditingController propsName = TextEditingController();
  TextEditingController propsBed = TextEditingController();
  TextEditingController propsBath = TextEditingController();
  TextEditingController propsToilet = TextEditingController();
  TextEditingController propsPrice = TextEditingController();
  TextEditingController propsDesc = TextEditingController();
  TextEditingController propsYoutubeId = TextEditingController();
  TextEditingController propsYearBuilt = TextEditingController();
  TextEditingController propsCondition = TextEditingController();
  TextEditingController propsCautionFee = TextEditingController();
  TextEditingController propsSpecialPref = TextEditingController();
  //
  TextEditingController shoppingController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController petrolController = TextEditingController();
  TextEditingController airportController = TextEditingController();
  TextEditingController churchController = TextEditingController();
  TextEditingController mosqueController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  //
  TextEditingController crimeController = TextEditingController();
  TextEditingController trafficController = TextEditingController();
  TextEditingController pollutionController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController healthController = TextEditingController();

  bool air_condition = false;
  bool balcony = false;
  bool bedding = false;
  bool cable_tv = false;
  bool cleaning_after_exist = false;
  bool coffee_pot = false;
  bool computer = false;
  bool cot = false;
  bool dishwasher = false;
  bool dvd = false;
  bool fan = false;
  bool fridge = false;
  bool grill = false;
  bool hairdryer = false;
  bool heater = false;
  bool hi_fi = false;
  bool internet = false;
  bool iron = false;
  bool juicer = false;
  bool lift = false;
  bool microwave = false;
  bool gym = false;
  bool fireplace = false;
  bool hot_tub = false;

  propertyModeEnum? _props_mode;

  List<States> stateList = [];
  List<Area> areaList = [];
  List<Area> areaListTemp = [];

  List<Property> propertyList = [];
  List<SubProperty> subPropertyList = [];
  List<SubProperty> subPropertyListTemp = [];

  String? states_id, area_id;

  String? props_type, sub_props_type;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    populateDropDown();
    setState(() {
      propsCautionFee.text = '0';
      propsCondition.text = 'none';
    });
  }

  populateDropDown() async {
    LocationModel data = await ApiServices.getStateRegion();
    PropertyAndSubTypesModel rata = await ApiServices.getPropertyAndSubTypes();
    setState(() {
      stateList = data.states;
      areaList = data.area;
      //
      propertyList = rata.property!;
      subPropertyList = rata.subProperty!;
    });
  }

  // final _propsPurposeList = ["Buy", "Rent"];
  final _propsPurposeList = [
    {"value": "buy", "name": "Buy"},
    {"value": "rent", "name": "Rent"},
  ];
  String? props_purpose;

  String outputSelectChipsInput = '';
  List<String> specialPref = [];
  String selectedPref = '';

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      //img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      // Navigator.of(context).pop();
    }
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Property Extra Details'),
          content: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsCondition,
                  fieldName: 'What are your conditions',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  myTextFormController: propsCautionFee,
                  fieldName: 'Caution / Damage Fee',
                ),
                const SizedBox(
                  height: 10,
                ),
                FlutterInputChips(
                  initialValue: const ['none'],
                  // maxChips: 5,
                  onChanged: (v) {
                    setState(() {
                      specialPref = v;
                      selectedPref = specialPref.join(',');
                    });
                  },
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Special Preference",
                  ),
                  chipTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  chipSpacing: 8,
                  chipDeleteIconColor: Colors.white,
                  chipBackgroundColor: Colors.blue,
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'use comma (,) to enter list of preference',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
            const PropertyAppBar(title: 'Edit Property -Extra Detail'),
            OrientationBuilder(
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
          if (propsCondition != '' &&
              propsCautionFee != '' &&
              selectedPref != '') {
            setState(() {
              isLoading = true;
            });
            print('form its filled');
            bool status = await propsController.editExtraDetail(
              propsCondition: propsCondition.text,
              propsCautionFee: propsCautionFee.text,
              selectedPref: selectedPref,
              propsId: widget.model.propsId!,
            );

            // if (status) {
            setState(() {
              isLoading = false;
            });
            // }
          } else {
            print('form not filled');
          }

          print('form selected == ${selectedPref}');
          print('Submited');
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
        return (isLoading)
            ? Center(
                child: Container(
                  child: LoadingAnimationWidget.inkDrop(
                    size: 200,
                    color: Colors.blue,
                  ),
                ),
              )
            : Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: ControlsDetails.onStepContinue,
                        child: (isLastStep)
                            ? const Text('Submit')
                            : const Text('Next'),
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
