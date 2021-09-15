import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

import '../../city_model.dart';

import 'package:http/http.dart' as http;

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provinsiID,
    required this.type
  }) : super(key: key);

  final int provinsiID;
  final String type;
  
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: type == "asal" ? "Kota/Kabupaten Asal" : "Kota Tujuan",
        showClearButton: true,
        onFind: (String filter) async {
          
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/city?province=$provinsiID");

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

            var listAllkota = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllkota);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        onChanged: (kota) {
             if(kota != null) {
              
              if(type == "asal") {
                 controller.kotaAsalId.value = int.parse(kota.cityId!);
              } else {
                 controller.kotaTujuanId.value = int.parse(kota.cityId!);
              }
              
            } else {
              if(type == "asal") {
                print("Tidak ada kota asal di pilih");
              } else {
                 print("Tidak ada kota tujuan di pilih");
              }
              
            }
             controller.showButton();
        },
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "cari kota...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => item.cityName!,
      ),
    );
  }
}
