import 'dart:io';

import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:oga_bliss/widget/my_money_field.dart';
import 'package:oga_bliss/widget/my_slide_checkbox.dart';
import 'package:oga_bliss/widget/my_text_field_num.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../model/property_type_model.dart';
import '../model/state_model.dart';
import '../services/api_services.dart';
import '../widget/my_dropdown_field.dart';
import '../widget/my_raidio_field.dart';
import '../widget/my_text_field.dart';
import '../widget/property_app_bar.dart';

class EditBasicDetail extends StatefulWidget {
  EditBasicDetail({required this.model});
  final PropertyModel model;

  @override
  State<EditBasicDetail> createState() => _EditBasicDetailState();
}

class _EditBasicDetailState extends State<EditBasicDetail> {
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
  //
  bool slightNegotiate = false;

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
    print(widget.model.propsId);
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
    {"value": "sale", "name": "Buy"},
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

  final String NGN = cSymbol("NGN");
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  String disAmount = "0";

  //year property built
  final _yearBuiltList = [
    {"value": "1 month", "name": "1 Month"},
    {"value": "2 month", "name": "2 Months"},
    {"value": "3 month", "name": "3 Months"},
    {"value": "4 month", "name": "4 Months"},
    {"value": "5 month", "name": "5 Months"},
    {"value": "6 month+", "name": "6 Months+"},
    {"value": "1 Year", "name": "1 Year"},
    {"value": "2 Year", "name": "2 Year"},
    {"value": "3 Year", "name": "3 Year"},
    {"value": "4 Year", "name": "4 Year"},
    {"value": "5 Year", "name": "5 Year"},
    {"value": "6 Year", "name": "6 Year"},
    {"value": "7 Year", "name": "7 Year"},
    {"value": "8 Year", "name": "8 Year"},
    {"value": "9 Year", "name": "9 Year"},
    {"value": "10 Year+", "name": "10 Year+"},
    {"value": "20 Year+", "name": "10 Year+"},
  ];
  String? selectedYearBuilt;

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Basic Information'),
              Text(
                'all fields are required & must be filled out'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
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
                MyDropDownField(
                  labelText: 'Property Type',
                  value: props_type,
                  dropDownList: propertyList.map(
                    (e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name.toString(),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (Object? val) {
                    setState(() {
                      sub_props_type = null;
                      props_type = val.toString();
                      subPropertyListTemp = subPropertyList
                          .where(
                            (element) =>
                                element.typeId.toString() ==
                                props_type.toString(),
                          )
                          .toList();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                MyDropDownField(
                  labelText: 'Sub Property Type',
                  value: sub_props_type,
                  dropDownList: subPropertyListTemp
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.name!),
                        ),
                      )
                      .toList(),
                  onChanged: (Object? val) {
                    setState(() {
                      sub_props_type = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 8,
                ),
                MyNumField(
                  myTextFormController: propsBed,
                  fieldName: 'Bedroom',
                  hintText: '3',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyNumField(
                  myTextFormController: propsBath,
                  fieldName: 'Bathrooms',
                  hintText: '5',
                ),
                const SizedBox(
                  height: 8,
                ),
                MyNumField(
                  myTextFormController: propsToilet,
                  fieldName: 'Toilets',
                  hintText: '2',
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('State & Area, Price'),
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
                  value: states_id,
                  items: stateList
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name.toString()),
                          ))
                      .toList(),
                  onChanged: (Object? val) {
                    setState(() {
                      area_id = null;
                      states_id = val.toString();
                      areaListTemp = areaList
                          .where(
                            (element) =>
                                element.stateId.toString() ==
                                states_id.toString(),
                          )
                          .toList();
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
                  value: area_id,
                  items: areaListTemp
                      .map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (Object? val) {
                    setState(() {
                      area_id = val.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                // MyTextField(
                //   myTextFormController: propsPrice,
                //   fieldName: 'Price',
                // ),
                MyMoneyField(
                  myTextFormController: propsPrice,
                  fieldName: 'Amount',
                  prefix: Icons.attach_money,
                  onChange: (string) {
                    if (propsPrice.text.isNotEmpty) {
                      string = '${_formatNumber(string.replaceAll(',', ''))}';
                      propsPrice.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    } else {
                      setState(() {
                        string = '0';
                      });
                    }
                    setState(() {
                      disAmount = string;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    MySlideCheckBox(
                      isSwitched: slightNegotiate,
                      onChanged: (value) {
                        setState(() {
                          slightNegotiate = value;
                        });
                      },
                    ),
                    const Text('Slightly Negotiable?'),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: propsDesc,
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
                    labelText: 'Description',
                    hintText: 'Product Description',
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Write in details about this property',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyDropDownField(
                  labelText: 'How old is the Property',
                  value: selectedYearBuilt,
                  dropDownList: List.generate(
                    _yearBuiltList.length,
                    (i) => DropdownMenuItem(
                      value: _yearBuiltList[i]["value"],
                      child: Text("${_yearBuiltList[i]["name"]}"),
                    ),
                  ),
                  onChanged: (Object? value) {
                    setState(() {
                      selectedYearBuilt = value.toString();
                    });
                  },
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
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
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
            const PropertyAppBar(title: 'Edit Property - Basic Detail'),
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
          bool status = await propsController.editBasicDetail(
            propsName: propsName.text,
            props_purpose: props_purpose ?? "",
            props_type: props_type ?? "",
            sub_props_type: sub_props_type ?? "",
            propsBed: propsBed.text,
            propsBath: propsBath.text,
            propsToilet: propsToilet.text,
            state_id: states_id ?? "",
            area_id: area_id ?? "",
            propsPrice: disAmount,
            propsDesc: propsDesc.text,
            propsYearBuilt: selectedYearBuilt ?? "",
            props_mode: _props_mode.toString() ?? "",
            propsYoutubeId: propsYoutubeId.text,
            propsId: widget.model.propsId ?? "",
            model: widget.model,
            slightNegotiate: slightNegotiate.toString(),
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
