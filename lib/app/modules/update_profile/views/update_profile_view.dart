import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;
  UpdateProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.nipController.text = user["nip"];
    controller.nameController.text = user["name"];
    controller.emailController.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPDATE PROFILE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            readOnly: false,
            autocorrect: false,
            controller: controller.nipController,
            decoration: const InputDecoration(
              labelText: "NIP",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            readOnly: false,
            autocorrect: false,
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            readOnly: false,
            autocorrect: false,
            controller: controller.nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Photo Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: unrelated_type_equality_checks
              user["profile"] != null && ["profile"] != ""
                  ? const Text("Foto Profile")
                  : const Text("No Choosen!"),
              TextButton(
                onPressed: () {},
                child: const Text("Choose"),
              )
            ],
          ),
          const SizedBox(height: 30),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: Text(
                controller.isLoading.isFalse ? "Update Profile" : "Loading...",
              ),
            ),
          )
        ],
      ),
    );
  }
}
