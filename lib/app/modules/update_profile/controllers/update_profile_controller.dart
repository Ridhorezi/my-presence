import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ignore: avoid_print
      print(image!.name);
      // ignore: avoid_print
      print(image!.name.split(".").last);
      // ignore: avoid_print
      print(image!.path);
    } else {
      // ignore: avoid_print
      print(image);
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nipController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await firestore.collection("pegawai").doc(uid).update({
          "name": nameController.text,
        });
        Get.snackbar("Sukses", "Profile berhasil di update");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile.");
      } finally {
        isLoading.value = false;
      }
    }
  }
}
