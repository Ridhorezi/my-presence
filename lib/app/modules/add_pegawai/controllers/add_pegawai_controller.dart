// ignore_for_file: unnecessary_overrides, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passwordAdminController.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;

        // ignore: unused_local_variable
        UserCredential userCredentialAdmin =
            await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passwordAdminController.text,
        );
        // ignore: unused_local_variable
        UserCredential pegawaiCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: "password",
        );
        if (pegawaiCredential.user != null) {
          // ignore: unused_local_variable
          String uid = pegawaiCredential.user!.uid;

          await firestore.collection("pegawai").doc(uid).set({
            "nip": nipController.text,
            "name": nameController.text,
            "email": emailController.text,
            "uid": uid,
            "createdAt": DateTime.now().toIso8601String(),
          });
          await pegawaiCredential.user!.sendEmailVerification();
          await auth.signOut();

          // ignore: unused_local_variable
          UserCredential userCredentialAdmin =
              await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passwordAdminController.text,
          );

          Get.back();
          Get.back();

          Get.snackbar("Sukses", "Pegawai berhasil di tambahkan");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Password yang di gunakan terlalu singkat!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan",
              "Email sudah di gunakan, kamu tidak dapat menambahkan akun menggunakan email ini");
        } else if (e.code == 'wrong-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "Admin tidak dapat login, Password salah!");
        } else {
          Get.snackbar("Terjadi Kesalahan", "${e.code}");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai!");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Password wajib di isi");
    }
  }

  void addPegawai() async {
    if (nameController.text.isNotEmpty &&
        nipController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text("Masukan password untuk validasi admin!"),
            TextField(
              controller: passwordAdminController,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () async {
              await prosesAddPegawai();
            },
            child: const Text("Add Pegawai"),
          )
        ],
      );
    } else {
      Get.snackbar("Terjadi Kesalahan", "NIP, Nama, dan Email harus di isi!");
    }
  }
}
