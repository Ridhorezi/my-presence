// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mypresence/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(Icons.person),
          )
          // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          //   stream: controller.streamRole(),
          //   builder: (context, snap) {
          //     if (snap.connectionState == ConnectionState.waiting) {
          //       return const SizedBox();
          //     }

          //     String role = snap.data!.data()!["role"];

          //     return IconButton(
          //       onPressed: () => Get.toNamed(
          //           (role == "admin") ? Routes.ADD_PEGAWAI : Routes.PROFILE),
          //       icon: const Icon(Icons.person),
          //     );
          //   },
          // ),
        ],
      ),
      body: const Center(
        child: Text(
          'On Progress',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          onPressed: () async {
            if (controller.isLoading.isFalse) {
              controller.isLoading.value = true;
              await FirebaseAuth.instance.signOut();
              controller.isLoading.value = false;
              Get.offAllNamed(Routes.LOGIN);
              Get.snackbar("Sukses", "Logout");
            }
          },
          child: controller.isLoading.isFalse
              ? const Icon(Icons.logout)
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
