// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// // import 'package:barcode_widget/barcode_widget.dart';
// import 'package:path/path.dart';
// import '../controllers/detail_item_controller.dart';
// // import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class DetailItemView extends GetView<DetailItemController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DetailItemView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(children: [
//           ElevatedButton(
//               onPressed: () {
//                 controller.scanBarcode();
//               },
//               child: Text("Klik Scan")),
//           Obx(() => Text(
//                 (controller.scanResult.value != null)
//                     ? "Hasil Scan : ${controller.scanResult.value}"
//                     : "Scan",
//               ))
//         ]),
//       ),
//     );
//   }
// }
