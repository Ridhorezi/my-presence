import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:mypresence/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';
import '../../../controllers/page_index_controller.dart';

class HomeView extends GetView<HomeController> {
  final pageController = Get.find<PageIndexController>();
  HomeView({Key? key}) : super(key: key);
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
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'On Progress',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Absensi'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: pageController.pageIndex.value,
        // ignore: avoid_print
        onTap: (int i) => pageController.changePage(i),
      ),
    );
  }
}
