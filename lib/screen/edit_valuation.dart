import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/model/property_model.dart';

import '../controller/property_controller.dart';
import '../model/property_type_model.dart';
import '../model/state_model.dart';
import '../services/api_services.dart';
import '../widget/my_raidio_field.dart';
import '../widget/my_text_field_num.dart';
import '../widget/property_app_bar.dart';

class EditValuation extends StatefulWidget {
  const EditValuation({required this.model});

  final PropertyModel model;

  @override
  State<EditValuation> createState() => _EditValuationState();
}

class _EditValuationState extends State<EditValuation> {
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
      // print(e);
      // Navigator.of(context).pop();
    }
  }

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
                MyNumField(
                  myTextFormController: crimeController,
                  fieldName: 'Crime',
                  hintText: 'e.g 10%',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: trafficController,
                  fieldName: 'Traffic',
                  hintText: 'e.g 60%',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: pollutionController,
                  fieldName: 'Pollution',
                  hintText: 'e.g 10%',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: educationController,
                  fieldName: 'Education',
                  hintText: 'e.g 80%',
                ),
                const SizedBox(
                  height: 10,
                ),
                MyNumField(
                  myTextFormController: healthController,
                  fieldName: 'Health',
                  hintText: 'e.g 90%',
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
            const PropertyAppBar(title: 'Edit Property - Valuation'),
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
          if (crimeController != '' &&
              trafficController != '' &&
              pollutionController != '' &&
              educationController != '' &&
              healthController != '') {
            setState(() {
              isLoading = true;
            });
            // print('form its filled');
            bool status = await propsController.editValuation(
              crime: crimeController.text,
              traffic: trafficController.text,
              pollution: pollutionController.text,
              education: educationController.text,
              health: healthController.text,
              propsId: widget.model.propsId!,
            );

            // if (status) {
            setState(() {
              isLoading = false;
            });
            // }
          } else {
            // print('form not filled');
          }

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
