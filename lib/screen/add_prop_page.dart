import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_input_chips/flutter_input_chips.dart';
import 'package:oga_bliss/widget/my_raidio_field.dart';
import 'package:text_chip_field/text_chip_field.dart';

import '../widget/my_dropdown_field.dart';
import '../widget/my_slide_checkbox.dart';
import '../widget/my_text_field.dart';
import '../widget/property_app_bar.dart';

class AddPropertyPage extends StatefulWidget {
  const AddPropertyPage({Key? key}) : super(key: key);

  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
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

  final _propsTypeList = ["Edo", "Delta", "Lagos", "Bayelsa", "Port-Harcourt"];
  String? props_type;

  // final _propsPurposeList = ["Buy", "Rent"];
  final _propsPurposeList = [
    {"value": "buy", "name": "Buy"},
    {"value": "rent", "name": "Rent"},
  ];
  String? props_purpose;

  String outputSelectChipsInput = '';
  List<String> specialPref = [];
  String selectedPref = '';

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Basic Information'),
          content: Container(
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                MyTextField(
                  myTextFormController: propsName,
                  fieldName: 'Property Name',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyDropDownField(
                  labelText: 'Property Purpose',
                  value: props_purpose,
                  dropDownList: List.generate(
                    _propsPurposeList.length,
                    (i) => DropdownMenuItem(
                      value: _propsPurposeList[i]["value"],
                      child: Text("${_propsPurposeList[i]["name"]}"),
                    ),
                  ),
                  onChanged: (Object? value) {
                    setState(() {
                      props_purpose = value.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Property Type',
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
                  value: props_type,
                  items: _propsTypeList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      props_type = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sub Property Type',
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
                  value: props_type,
                  items: _propsTypeList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      props_type = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsBed,
                  fieldName: 'Bedrooms',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsBath,
                  fieldName: 'Bathrooms',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsToilet,
                  fieldName: 'Toilets',
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('State & Area, Price'),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'State',
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
                  value: props_type,
                  items: _propsTypeList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      props_type = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Area',
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
                  value: props_type,
                  items: _propsTypeList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      props_type = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsPrice,
                  fieldName: 'Price',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsDesc,
                  fieldName: 'Property Desc',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  myTextFormController: propsYearBuilt,
                  fieldName: 'Year Built',
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Property  Mode'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('What is the Property Mode?'),
                      MyRadioBtnField(
                        title: '${propertyModeEnum.New.name} Property',
                        value: propertyModeEnum.New,
                        selectedProperty: _props_mode,
                        onChanged: (val) {
                          setState(() {
                            _props_mode = val;
                          });
                        },
                      ),
                      MyRadioBtnField(
                        title: '${propertyModeEnum.Furnished.name} Property',
                        value: propertyModeEnum.Furnished,
                        selectedProperty: _props_mode,
                        onChanged: (val) {
                          setState(() {
                            _props_mode = val;
                          });
                        },
                      ),
                      MyRadioBtnField(
                        title: '${propertyModeEnum.Serviced.name} Property',
                        value: propertyModeEnum.Serviced,
                        selectedProperty: _props_mode,
                        onChanged: (val) {
                          setState(() {
                            _props_mode = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                    myTextFormController: propsYoutubeId,
                    fieldName: 'Youtube Video Id',
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
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
            state:
                _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 3,
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
                  MyTextField(
                    myTextFormController: propsCautionFee,
                    fieldName: 'Special Preference',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FlutterInputChips(
                    initialValue: const [],
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
                      'Enter Preference separated by comma (,)',
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
            )),
        Step(
            state:
                _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 4,
            title: const Text('Add Image'),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: propsName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full House Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: propsDesc,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pin Code',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 5,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${air_condition}'),
                Text('Email: ${propsDesc.text}'),
                const Text('Password: *****'),
                Text('Address : ${propsYearBuilt.text}'),
                Text('PinCode : ${propsPrice.text}'),
              ],
            )))
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PropertyAppBar(title: 'Add Property'),
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
      onStepContinue: () {
        if (_activeStepIndex < (stepList().length - 1)) {
          setState(() {
            _activeStepIndex += 1;
          });
        } else {
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
