import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';
// import 'package:owl_flutter/app/assets/models/newsmodel.dart';
import 'package:owl_flutter/app/assets/models/readnews.dart';
import 'package:owl_flutter/app/assets/models/tablenews.dart';

import 'package:owl_flutter/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/home_list_controller.dart';

class HomeListView extends GetView<HomeListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.offAndToNamed(Routes.HOME),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.offAndToNamed(Routes.HOME_GRID_VIEW);
              },
              icon: Icon(Icons.grid_on_outlined)),
        ],
        title: Center(
          child: Text(
            "Daftar Barang",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: controller.getNewsData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Obx(() => (controller.allNewsData.length == null)
                  ? Center(
                      child: Text(
                        "Data Tidak Ada",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => controller.getNewsData(),
                      child: (controller.isloading.value)
                          ? CircularProgressIndicator()
                          // : Text("loading")
                          : ListView.builder(
                              itemCount: controller.allNewsData.length,
                              itemBuilder: (context, index) {
                                TableNews newsBody =
                                    controller.allNewsData[index];

                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.README_NEWS,
                                          arguments: [
                                            {
                                              "title": newsBody.title,
                                              "content": newsBody.content,
                                              "description":
                                                  newsBody.description,
                                              "id_news":
                                                  newsBody.idNews.toString()
                                            },
                                          ]);
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: 100,
                                        color: kLightgreen,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  "${newsBody.imageUrl}",
                                                  fit: BoxFit.fill,
                                                ),
                                                color: Colors.transparent),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  bottom: 2,
                                                  right: 2),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${newsBody.title} ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                    ),
                                                    height: 30,
                                                    width: 250,
                                                  ),
                                                  SizedBox(
                                                    height: 1,
                                                  ),
                                                  Container(
                                                    width: 250,
                                                    child: Text(
                                                      "${newsBody.content}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              }),
                    ));
            }),
          ),
        ),
      ),
    );
  }
}
