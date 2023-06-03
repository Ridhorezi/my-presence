// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPegawai() async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      // execute
      try {
        // ignore: unused_local_variable
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: "password",
        );
        if (userCredential.user != null) {
          // ignore: unused_local_variable
          String? uid = userCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipController.text,
            "name": nameController.text,
            "email": emailController.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });
          Get.snackbar("Sukses", "Pegawai berhasil di tambahkan");
          await userCredential.user!.sendEmailVerification();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Password yang di gunakan terlalu singkat!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "Email sudah di gunakan, kamu tidak dapat menambahkan akun menggunakan email ini");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai!");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, Nama, dan Email harus di isi!");
    }
  }
}
