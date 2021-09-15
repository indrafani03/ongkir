import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.beratC,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                  labelText: "Berat barang",
                  border: OutlineInputBorder(),
                  hintText: "Berat barang"),
              onChanged: (value) {
                controller.showButton();
                controller.ubahBerat(value!);
              } 
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItem: true,
                items: [
                  "ton", 
                  "kwintal",
                  "ons",
                  "pound",
                  "hg",
                  "dag",
                  "gram",
                  "cg",
                  "mg",
                  ],
                label: "Satuan berat",
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (value) {
                  controller.ubahSatuan(value!);
                  controller.showButton();
                } ,
                selectedItem: "gram"),
          )
        ],
      ),
    );
  }
}
