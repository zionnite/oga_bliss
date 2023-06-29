// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

List<PropertyModel?>? propertyModelFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<PropertyModel?>.from(
            json.decode(str)!.map((x) => PropertyModel.fromJson(x)));

String propertyModelToJson(List<PropertyModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class PropertyModel {
  PropertyModel({
    this.propsId,
    this.propsAgentId,
    this.propsName,
    this.propsLocation,
    this.propsImgName,
    this.propsVidId,
    this.propsType,
    this.propsPurpose,
    this.propsStatus,
    this.propsBedrom,
    this.propsBed,
    this.propsBathroom,
    this.propsToilet,
    this.propsHomeArea,
    this.propsLotArea,
    this.propsYearBuilt,
    this.propsCreated,
    this.propsStateId,
    this.propsSubStateId,
    this.propsTypeOfPropery,
    this.propsSubTypeOfPropery,
    this.propsPrice,
    this.propsDescription,
    this.propMode,
    this.propsShoppingMall,
    this.propsHospital,
    this.propsSchool,
    this.propsPetrolPump,
    this.propsAirport,
    this.propsChurch,
    this.propsMosque,
    this.propsAirCondition,
    this.propsBalcony,
    this.propsBedding,
    this.propsCableTv,
    this.propsCleaningAfterExit,
    this.propsCofeePot,
    this.propsComputer,
    this.propsCot,
    this.propsDishwasher,
    this.propsDvd,
    this.propsFan,
    this.propsFridge,
    this.propsGrill,
    this.propsHairdryer,
    this.propsHeater,
    this.propsHiFi,
    this.propsInternet,
    this.propsIron,
    this.propsJuicer,
    this.propsLift,
    this.propsMicrowave,
    this.propsGym,
    this.propsFireplace,
    this.propsHotTub,
    this.propsCrime,
    this.propsTraffic,
    this.propsPollution,
    this.propsEducation,
    this.propsHealth,
    this.propsCondition,
    this.propsCautionFee,
    this.propsSpecialPref,
    this.propsLiveStatus,
    this.sliderImg,
    this.getAllPropsImage,
    this.getAllPropsVideo,
    this.getStateName,
    this.getSubStateName,
    this.countPropsImage,
    this.favourite,
    this.typeName,
    this.subTypeName,
    this.agentFullName,
    this.agentImageName,
    this.agentEmail,
    this.agentStatus,
    this.agentUserName,
    this.agentUserPhone,
    this.agentPropCounter,
    this.propsNegotiable,
    this.isPromotingProduct,
    this.urlCode,
  });

  String? propsId;
  String? propsAgentId;
  String? propsName;
  String? propsLocation;
  String? propsImgName;
  String? propsVidId;
  String? propsType;
  String? propsPurpose;
  String? propsStatus;
  String? propsBedrom;
  String? propsBed;
  String? propsBathroom;
  String? propsToilet;
  String? propsHomeArea;
  String? propsLotArea;
  String? propsYearBuilt;
  String? propsCreated;
  String? propsStateId;
  String? propsSubStateId;
  String? propsTypeOfPropery;
  String? propsSubTypeOfPropery;
  String? propsPrice;
  String? propsDescription;
  String? propMode;
  dynamic? propsShoppingMall;
  dynamic? propsHospital;
  dynamic? propsSchool;
  dynamic? propsPetrolPump;
  dynamic? propsAirport;
  dynamic? propsChurch;
  dynamic? propsMosque;
  dynamic? propsAirCondition;
  dynamic? propsBalcony;
  dynamic? propsBedding;
  dynamic? propsCableTv;
  dynamic? propsCleaningAfterExit;
  dynamic? propsCofeePot;
  dynamic? propsComputer;
  dynamic? propsCot;
  dynamic? propsDishwasher;
  dynamic? propsDvd;
  dynamic? propsFan;
  dynamic? propsFridge;
  dynamic? propsGrill;
  dynamic? propsHairdryer;
  dynamic? propsHeater;
  dynamic? propsHiFi;
  dynamic? propsInternet;
  dynamic? propsIron;
  dynamic? propsJuicer;
  dynamic? propsLift;
  dynamic? propsMicrowave;
  dynamic? propsGym;
  dynamic? propsFireplace;
  dynamic? propsHotTub;
  dynamic? propsCrime;
  dynamic? propsTraffic;
  dynamic? propsPollution;
  dynamic? propsEducation;
  dynamic? propsHealth;
  dynamic? propsCondition;
  dynamic? propsCautionFee;
  dynamic? propsSpecialPref;
  String? propsLiveStatus;
  String? sliderImg;
  List<GetAllPropsImage?>? getAllPropsImage;
  bool? getAllPropsVideo;
  dynamic getStateName;
  dynamic getSubStateName;
  int? countPropsImage;
  bool? favourite;
  dynamic typeName;
  dynamic subTypeName;
  String? agentFullName;
  String? agentImageName;
  String? agentEmail;
  String? agentStatus;
  String? agentUserName;
  String? agentUserPhone;
  int? agentPropCounter;
  String? propsNegotiable;
  bool? isPromotingProduct;
  String? urlCode;

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        propsId: json["props_id"],
        propsAgentId: json["props_agent_id"],
        propsName: json["props_name"],
        propsLocation: json["props_location"],
        propsImgName: json["props_img_name"],
        propsVidId: json["props_vid_id"],
        propsType: json["props_type"],
        propsPurpose: json["props_purpose"],
        propsStatus: json["props_status"],
        propsBedrom: json["props_bedrom"],
        propsBed: json["props_bed"],
        propsBathroom: json["props_bathroom"],
        propsToilet: json["props_toilet"],
        propsHomeArea: json["props_home_area"],
        propsLotArea: json["props_lot_area"],
        propsYearBuilt: json["props_year_built"],
        propsCreated: json["props_created"],
        propsStateId: json["props_state_id"],
        propsSubStateId: json["props_sub_state_id"],
        propsTypeOfPropery: json["props_type_of_propery"],
        propsSubTypeOfPropery: json["props_sub_type_of_propery"],
        propsPrice: json["props_price"],
        propsDescription: json["props_description"],
        propMode: json["prop_mode"],
        propsShoppingMall: json["props_shopping_mall"],
        propsHospital: json["props_hospital"],
        propsSchool: json["props_school"],
        propsPetrolPump: json["props_petrol_pump"],
        propsAirport: json["props_airport"],
        propsChurch: json["props_church"],
        propsMosque: json["props_mosque"],
        propsAirCondition: json["props_air_condition"],
        propsBalcony: json["props_balcony"],
        propsBedding: json["props_bedding"],
        propsCableTv: json["props_cable_tv"],
        propsCleaningAfterExit: json["props_cleaning_after_exit"],
        propsCofeePot: json["props_cofee_pot"],
        propsComputer: json["props_computer"],
        propsCot: json["props_cot"],
        propsDishwasher: json["props_dishwasher"],
        propsDvd: json["props_dvd"],
        propsFan: json["props_fan"],
        propsFridge: json["props_fridge"],
        propsGrill: json["props_grill"],
        propsHairdryer: json["props_hairdryer"],
        propsHeater: json["props_heater"],
        propsHiFi: json["props_hi_fi"],
        propsInternet: json["props_internet"],
        propsIron: json["props_iron"],
        propsJuicer: json["props_juicer"],
        propsLift: json["props_lift"],
        propsMicrowave: json["props_microwave"],
        propsGym: json["props_gym"],
        propsFireplace: json["props_fireplace"],
        propsHotTub: json["props_hot_tub"],
        propsCrime: json["props_crime"],
        propsTraffic: json["props_traffic"],
        propsPollution: json["props_pollution"],
        propsEducation: json["props_education"],
        propsHealth: json["props_health"],
        propsCondition: json["props_condition"],
        propsCautionFee: json["props_caution_fee"],
        propsSpecialPref: json["props_special_pref"],
        propsLiveStatus: json["props_live_status"],
        sliderImg: json["slider_img"],
        getAllPropsImage: json["get_all_props_image"] == null
            ? []
            : List<GetAllPropsImage?>.from(json["get_all_props_image"]!
                .map((x) => GetAllPropsImage.fromJson(x))),
        getAllPropsVideo: json["get_all_props_video"],
        getStateName: json["get_state_name"],
        getSubStateName: json["get_sub_state_name"],
        countPropsImage: json["count_props_image"],
        favourite: json["favourite"],
        typeName: json["type_name"],
        subTypeName: json["sub_type_name"],
        agentFullName: json["agent_full_name"],
        agentImageName: json["agent_image_name"],
        agentEmail: json["agent_email"],
        agentStatus: json["agent_status"],
        agentUserName: json["agent_user_name"],
        agentUserPhone: json["agent_user_phone"],
        agentPropCounter: json["agent_prop_counter"],
        propsNegotiable: json["props_negotiable"],
        isPromotingProduct: json["is_promoting_product"],
        urlCode: json["url_code"],
      );

  Map<String, dynamic> toJson() => {
        "props_id": propsId,
        "props_agent_id": propsAgentId,
        "props_name": propsName,
        "props_location": propsLocation,
        "props_img_name": propsImgName,
        "props_vid_id": propsVidId,
        "props_type": propsType,
        "props_purpose": propsPurpose,
        "props_status": propsStatus,
        "props_bedrom": propsBedrom,
        "props_bed": propsBed,
        "props_bathroom": propsBathroom,
        "props_toilet": propsToilet,
        "props_home_area": propsHomeArea,
        "props_lot_area": propsLotArea,
        "props_year_built": propsYearBuilt,
        "props_created": propsCreated,
        "props_state_id": propsStateId,
        "props_sub_state_id": propsSubStateId,
        "props_type_of_propery": propsTypeOfPropery,
        "props_sub_type_of_propery": propsSubTypeOfPropery,
        "props_price": propsPrice,
        "props_description": propsDescription,
        "prop_mode": propMode,
        "props_shopping_mall": propsShoppingMall,
        "props_hospital": propsHospital,
        "props_school": propsSchool,
        "props_petrol_pump": propsPetrolPump,
        "props_airport": propsAirport,
        "props_church": propsChurch,
        "props_mosque": propsMosque,
        "props_air_condition": propsAirCondition,
        "props_balcony": propsBalcony,
        "props_bedding": propsBedding,
        "props_cable_tv": propsCableTv,
        "props_cleaning_after_exit": propsCleaningAfterExit,
        "props_cofee_pot": propsCofeePot,
        "props_computer": propsComputer,
        "props_cot": propsCot,
        "props_dishwasher": propsDishwasher,
        "props_dvd": propsDvd,
        "props_fan": propsFan,
        "props_fridge": propsFridge,
        "props_grill": propsGrill,
        "props_hairdryer": propsHairdryer,
        "props_heater": propsHeater,
        "props_hi_fi": propsHiFi,
        "props_internet": propsInternet,
        "props_iron": propsIron,
        "props_juicer": propsJuicer,
        "props_lift": propsLift,
        "props_microwave": propsMicrowave,
        "props_gym": propsGym,
        "props_fireplace": propsFireplace,
        "props_hot_tub": propsHotTub,
        "props_crime": propsCrime,
        "props_traffic": propsTraffic,
        "props_pollution": propsPollution,
        "props_education": propsEducation,
        "props_health": propsHealth,
        "props_condition": propsCondition,
        "props_caution_fee": propsCautionFee,
        "props_special_pref": propsSpecialPref,
        "props_live_status": propsLiveStatus,
        "slider_img": sliderImg,
        "get_all_props_image": getAllPropsImage == null
            ? []
            : List<dynamic>.from(getAllPropsImage!.map((x) => x!.toJson())),
        "get_all_props_video": getAllPropsVideo,
        "get_state_name": getStateName,
        "get_sub_state_name": getSubStateName,
        "count_props_image": countPropsImage,
        "favourite": favourite,
        "type_name": typeName,
        "sub_type_name": subTypeName,
        "agent_full_name": agentFullName,
        "agent_image_name": agentImageName,
        "agent_email": agentEmail,
        "agent_status": agentStatus,
        "agent_user_name": agentUserName,
        "agent_user_phone": agentUserPhone,
        "agent_prop_counter": agentPropCounter,
        "props_negotiable": propsNegotiable,
        "is_promoting_product": isPromotingProduct,
        "url_code": urlCode,
      };
}

class GetAllPropsImage {
  GetAllPropsImage({
    this.id,
    this.propId,
    this.imageName,
  });

  String? id;
  String? propId;
  String? imageName;

  factory GetAllPropsImage.fromJson(Map<String, dynamic> json) =>
      GetAllPropsImage(
        id: json["id"],
        propId: json["prop_id"],
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prop_id": propId,
        "image_name": imageName,
      };
}
