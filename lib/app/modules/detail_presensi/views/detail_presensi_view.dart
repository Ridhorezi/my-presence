import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL PRESENSI'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            // ignore: sort_child_properties_last
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    // ignore: unnecessary_string_interpolations
                    "${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Masuk",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text("Jam : ${DateFormat.jms().format(DateTime.now())}"),
                const Text("Posisi : -6.32436, 192.76476"),
                const Text("Status : Di dalam area"),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Keluar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text("Jam : ${DateFormat.jms().format(DateTime.now())}"),
                const Text("Posisi : -6.32436, 192.76476"),
                const Text("Status : Di dalam area"),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200,
            ),
          ),
        ],
      ),
    );
  }
}
