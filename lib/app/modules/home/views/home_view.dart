import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(''),
          centerTitle: true,
        ),
        body: Center(
            child: Lottie.asset("lib/app/assets/lottie/lottie_dancer.zip")),
        bottomNavigationBar: ConvexAppBar(
            style: TabStyle.textIn,
            items: [
              TabItem(icon: Icons.list_alt, title: 'List'),
              TabItem(icon: Icons.qr_code, title: 'Scan'),
              TabItem(icon: Icons.home, title: 'Home'),
              TabItem(icon: Icons.message, title: 'Message'),
              TabItem(icon: Icons.add, title: 'Tambah'),
            ],
            initialActiveIndex: 2, //optional, default as 0
            onTap: (int i) {
              controller.pilihan.value = i;
              controller.selectIndex();
            }));
  }
}
