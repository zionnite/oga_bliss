import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/my_dropdown_field.dart';
import '../widget/my_text_field.dart';
import '../widget/property_app_bar.dart';

enum propertyMode { newly_built, furnished, serviced }

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

  bool? air_condition;
  bool? balcony;
  bool? bedding;
  bool? cable_tv;
  bool? cleaning_after_exist;
  bool? coffet_pot;
  bool? coffet_computer;
  bool? cot;
  bool? dishwasher;
  bool? dvd;
  bool? fan;
  bool? fridge;
  bool? grill;
  bool? hairdryer;
  bool? heater;
  bool? hi_fi;
  bool? internet;
  bool? iron;
  bool? juicer;
  bool? lift;
  bool? mirowave;
  bool? gym;
  bool? fireplace;
  bool? hot_tub;

  propertyMode? _props_mode;

  final _propsTypeList = ["Edo", "Delta", "Lagos", "Bayelsa", "Port-Harcourt"];
  String? props_type;

  // final _propsPurposeList = ["Buy", "Rent"];
  final _propsPurposeList = [
    {"value": "buy", "name": "Buy"},
    {"value": "rent", "name": "Rent"},
  ];
  String? props_purpose;

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
                TextField(
                  keyboardType: TextInputType.number,
                  controller: propsBed,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bedrooms',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: propsBath,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bathrooms',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: propsToilet,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Toilets',
                  ),
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
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [],
                  controller: propsPrice,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: propsDesc,
                  maxLines: 5,
                  minLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Property Desc',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: propsYearBuilt,
                  minLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Year Built',
                  ),
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
                Text('Name: ${props_purpose}'),
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
