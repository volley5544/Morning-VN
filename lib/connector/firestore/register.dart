import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/subdistrict_model.dart';

class RegisterConnector {
  Future<List<dynamic>> getProvince() async {
    List<dynamic> name = [];
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('address_master')
        .doc('master')
        .get();
    name = document['sub'];
    return name;
  }

  Future<List<dynamic>> getDistrict(String province) async {
    List<dynamic> name = [];
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('address_master')
        .doc(province)
        .get();
    if (document.data() != null) name = document['sub'];

    return name;
  }

  Future<List<Subdistrict>> getSubDistrict(String district) async {
    List<Subdistrict> list = [];
    print(district);
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('address_master')
        .doc(district)
        .get();

    List<dynamic> data = document['sub'];

    for (int i = 0; i < data.length; i++) {
      list.add(Subdistrict.fromJson(data[i]));
    }
    return list;
  }
}
