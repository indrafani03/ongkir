import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/courier_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var hiddenAsalKota = true.obs;
  var provAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hiddenTujuanKota = true.obs;
  var provTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hiddenButton = true.obs;
  var kurir = "".obs;

  double berat = 0.0;
  String satuan = "gram";

  late TextEditingController beratC;

  void ongkosKirim() async {
    var url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    showButton();
    try{
      var response = await http.post(url, headers: {
       "key" : "4ad06fd00bc022c31a25f3fdebcb037c",
       "content-type" : "application/x-www-form-urlencoded",
     }, body:  {
       "origin" : "$kotaAsalId",
       "destination" : "$kotaTujuanId",
       "weight" : "$berat",
       "courier" : "$kurir",
     });
     var data = jsonDecode(response.body) as Map<String, dynamic>;
     var results = data["rajaongkir"]["results"] as List<dynamic>;
     var listAllCourier =Courier.fromJsonList(results);
     var courier  = listAllCourier[0];

     Get.defaultDialog(
       title: courier.name!,
      content : Column(
        children: 
          courier.costs!.map((e) => ListTile(
            title : Text("${e.service}"),
            subtitle: Text("Rp ${e.cost![0].value}"),
            trailing: Text(courier.code == "pos" ? "${e.cost![0].etd}" : "${e.cost![0].etd} HARI"),
            
          )).toList()
        
      ),
     );

    
    }catch(e) {
      print(e.toString());
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: e.toString(),
      );
    }
     
} 

  void showButton() {
    if (kotaAsalId != null && kotaTujuanId != null && berat > 0 && kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 100;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dg":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    print(berat);
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2204.62;
        break;
      case "pound":
        berat = berat * 100;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dg":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }

    satuan = value;
    print("$berat gram");
  }

  @override
  void onInit() {
    beratC = TextEditingController(text: "${berat}");
    super.onInit();
  }

  @override
  void onClose() {
    beratC.dispose();
    super.onClose();
  }
}
