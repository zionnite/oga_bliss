import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../model/property_type_model.dart';
import '../model/state_model.dart';
import '../services/api_services.dart';
import '../widget/my_raidio_field.dart';
import '../widget/my_slide_checkbox.dart';
import '../widget/property_app_bar.dart';

class EditAmenities extends StatefulWidget {
  EditAmenities({required this.model});
  final PropertyModel model;

  @override
  State<EditAmenities> createState() => _EditAmenitiesState();
}

class _EditAmenitiesState extends State<EditAmenities> {
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
            state:
                _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 0,
            title: const Text('Amenities'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                      'Kindly select the type that applies to your property'),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: air_condition,
                        onChanged: (value) {
                          setState(() {
                            air_condition = value;
                          });
                        },
                      ),
                      const Text('Air Condition'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: balcony,
                        onChanged: (value) {
                          setState(() {
                            balcony = value;
                          });
                        },
                      ),
                      const Text('Balcony'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: bedding,
                        onChanged: (value) {
                          setState(() {
                            bedding = value;
                          });
                        },
                      ),
                      const Text('Bedding'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: cable_tv,
                        onChanged: (value) {
                          setState(() {
                            cable_tv = value;
                          });
                        },
                      ),
                      const Text('Cable Tv'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: cleaning_after_exist,
                        onChanged: (value) {
                          setState(() {
                            cleaning_after_exist = value;
                          });
                        },
                      ),
                      const Text('Cleaning After Exist'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: coffee_pot,
                        onChanged: (value) {
                          setState(() {
                            coffee_pot = value;
                          });
                        },
                      ),
                      const Text('Coffee Pot'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: computer,
                        onChanged: (value) {
                          setState(() {
                            computer = value;
                          });
                        },
                      ),
                      const Text('Computer'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: cot,
                        onChanged: (value) {
                          setState(() {
                            cot = value;
                          });
                        },
                      ),
                      const Text('Cot'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: dishwasher,
                        onChanged: (value) {
                          setState(() {
                            dishwasher = value;
                          });
                        },
                      ),
                      const Text('Dish Washer'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: dvd,
                        onChanged: (value) {
                          setState(() {
                            dvd = value;
                          });
                        },
                      ),
                      const Text('DVD'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: fridge,
                        onChanged: (value) {
                          setState(() {
                            fridge = value;
                          });
                        },
                      ),
                      const Text('Fridge'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: grill,
                        onChanged: (value) {
                          setState(() {
                            grill = value;
                          });
                        },
                      ),
                      const Text('Grill'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: hairdryer,
                        onChanged: (value) {
                          setState(() {
                            hairdryer = value;
                          });
                        },
                      ),
                      const Text('Hair Dryer'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: heater,
                        onChanged: (value) {
                          setState(() {
                            heater = value;
                          });
                        },
                      ),
                      const Text('Heater'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: hi_fi,
                        onChanged: (value) {
                          setState(() {
                            hi_fi = value;
                          });
                        },
                      ),
                      const Text('Hi-Fi'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: internet,
                        onChanged: (value) {
                          setState(() {
                            internet = value;
                          });
                        },
                      ),
                      const Text('Internet'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: iron,
                        onChanged: (value) {
                          setState(() {
                            iron = value;
                          });
                        },
                      ),
                      const Text('Iron'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: juicer,
                        onChanged: (value) {
                          setState(() {
                            juicer = value;
                          });
                        },
                      ),
                      const Text('Juicer'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: lift,
                        onChanged: (value) {
                          setState(() {
                            lift = value;
                          });
                        },
                      ),
                      const Text('Lift'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: microwave,
                        onChanged: (value) {
                          setState(() {
                            microwave = value;
                          });
                        },
                      ),
                      const Text('Microwave'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: gym,
                        onChanged: (value) {
                          setState(() {
                            gym = value;
                          });
                        },
                      ),
                      const Text('Gym'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: fireplace,
                        onChanged: (value) {
                          setState(() {
                            fireplace = value;
                          });
                        },
                      ),
                      const Text('Fireplace'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MySlideCheckBox(
                        isSwitched: hot_tub,
                        onChanged: (value) {
                          setState(() {
                            hot_tub = value;
                          });
                        },
                      ),
                      const Text('Hot Tub'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
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
            const PropertyAppBar(title: 'Edit Property -Amenities'),
            (isLoading)
                ? Center(
                    child: Container(
                      child: LoadingAnimationWidget.inkDrop(
                        size: 200,
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
          if (air_condition != '' &&
              balcony != '' &&
              bedding != '' &&
              cable_tv != '' &&
              cleaning_after_exist != '' &&
              coffee_pot != '' &&
              computer != '' &&
              cot != '' &&
              dishwasher != '' &&
              dvd != '' &&
              fan != '' &&
              fridge != '' &&
              grill != '' &&
              hairdryer != '' &&
              heater != '' &&
              hi_fi != '' &&
              internet != '' &&
              iron != '' &&
              juicer != '' &&
              lift != '' &&
              microwave != '' &&
              gym != '' &&
              fireplace != '' &&
              hot_tub != '') {
            setState(() {
              isLoading = true;
            });
            // print('form its filled');
            bool status = await propsController.editAmenities(
              air_condition: air_condition,
              balcony: balcony,
              bedding: bedding,
              cable_tv: cable_tv,
              cleaning_after_exist: cleaning_after_exist,
              coffee_pot: coffee_pot,
              computer: computer,
              cot: cot,
              dishwasher: dishwasher,
              dvd: dvd,
              fan: fan,
              fridge: fridge,
              grill: grill,
              hairdryer: hairdryer,
              heater: heater,
              hi_fi: hi_fi,
              internet: internet,
              iron: iron,
              juicer: juicer,
              lift: lift,
              microwave: microwave,
              gym: gym,
              fireplace: fireplace,
              hot_tub: hot_tub,
              propsId: widget.model.propsId!,
              user_id: user_id!,
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
