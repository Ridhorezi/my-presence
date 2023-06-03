// ignore_for_file: unnecessary_overrides

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypresence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      //execute
      try {
        // ignore: unused_local_variable
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // ignore: avoid_print
        print(userCredential);

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            if (passwordController.text == "password") {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.snackbar("Sukses", "anda berhasil login");
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Belum Terverifikasi",
              middleText:
                  "Kamu belum verifikasi akun ini, verifikasi akun melalu pesan email yang sudah kami kirim!",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(), // for closed dialogue
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "Sukses",
                        "Link verifikasi akun sudah kami kirim, silahkan cek email dan lakukan verifikasi akun.",
                      );
                    } catch (e) {
                      Get.snackbar(
                        "Terjadi Kegagalan",
                        "Tidak dapat mengirim email verifikasi, Silahkan hubungi admin atau CS kami.",
                      );
                    }
                  }, // send verification
                  child: const Text("KIRIM ULANG"),
                ),
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar!");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password tidak terdaftar!");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat login");
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password wajib di isi!");
    }
  }
}
