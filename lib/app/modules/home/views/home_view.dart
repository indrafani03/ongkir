import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkir/app/modules/home/views/widgets/berat.dart';
import 'package:ongkir/app/modules/home/views/widgets/city.dart';
import 'package:ongkir/app/modules/home/views/widgets/province.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swadikap'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Provinsi(
            type: "asal",
          ),
          Obx(
            () => controller.hiddenAsalKota.isTrue
                ? SizedBox()
                : Kota(
                    provinsiID: controller.provAsalId.value,
                    type: "asal",
                  ),
          ),
          Provinsi(
            type: "tujuan",
          ),
          Obx(
            () => controller.hiddenTujuanKota.isTrue
                ? SizedBox()
                : Kota(
                    provinsiID: controller.provTujuanId.value,
                    type: "tujuan",
                  ),
          ),
          BeratBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showClearButton: true,
              items: ["jne", "tiki", "pos"],
              label: "Kurir",
              hint: "country in menu mode",
              onChanged: (value) {
                if(value != null) {
                  // controller.hiddenButton.value = false;
                  controller.kurir.value = value;
                  controller.showButton();
                } else {
                  controller.hiddenButton.value = true;
                  controller.kurir.value = "";
                }
                
              },
            ),
          ),
          Obx(
            () => controller.hiddenButton.isFalse
                ? ElevatedButton(
                    onPressed: () => controller.ongkosKirim(),
                    child: Text("Cek Ongkir"),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        primary: Colors.blue[700]),
                  )
                : SizedBox(),
          )
        ],
      ),
    );
  }
}
