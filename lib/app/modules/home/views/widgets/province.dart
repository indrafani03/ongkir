

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

import 'package:http/http.dart' as http;

import '../../province_model.dart';
class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.type
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        label: type == "asal" ? "Provinsi Asal" : "Provinsi Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "4ad06fd00bc022c31a25f3fdebcb037c",
              },
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
         onChanged: (prov) {
            if(prov != null) {
             
              if(type == "asal") {
                controller.hiddenAsalKota.value = false;
                controller.provAsalId.value = int.parse(prov.provinceId!);
              } else {
                controller.hiddenTujuanKota.value = false;
                controller.provTujuanId.value = int.parse(prov.provinceId!);
              }
              
            } else {
              if(type == "asal") {
                controller.hiddenAsalKota.value = true;
                controller.provAsalId.value = 0;
              } else {
                controller.hiddenTujuanKota.value = true;
                controller.provTujuanId.value = 0;
              }
              print("Tidak ada provinsi di pilih");
            }
             controller.showButton();
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "cari provinsi...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.province}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => item.province!,
      ),
    );
  }
}
