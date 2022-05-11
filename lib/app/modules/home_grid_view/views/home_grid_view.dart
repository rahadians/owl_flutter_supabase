import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';
// import 'package:owl_flutter/app/assets/models/newsmodel.dart';
import 'package:owl_flutter/app/assets/models/readnews.dart';
import 'package:owl_flutter/app/assets/models/tablenews.dart';
import 'package:owl_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:owl_flutter/app/modules/home_grid_view/controllers/home_grid_view_controller.dart';
import 'package:owl_flutter/app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeGridViewView extends GetView<HomeGridViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.offAndToNamed(Routes.HOME),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.offAndToNamed(Routes.HOME_LIST);
              },
              icon: Icon(Icons.list_alt_outlined)),
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
          padding: const EdgeInsets.all(3.0),
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
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                // mainAxisExtent: 5,
                                childAspectRatio: 3 / 4,
                              ),
                              itemCount: controller.allNewsData.length,
                              itemBuilder: (context, index) {
                                TableNews newsBody =
                                    controller.allNewsData[index];

                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.README_NEWS,
                                        // arguments: [
                                        //   {
                                        //     "title": newsBody.title,
                                        //     "content": newsBody.content,
                                        //     "description": newsBody.description,
                                        //     "id_news":
                                        //         newsBody.idNews.toString()
                                        //   },
                                        // ],
                                      );
                                    },
                                    child: Card(
                                      color: kLightgreen,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        "${newsBody.imageUrl}",
                                                      ),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 3),
                                            child: Expanded(
                                              child: Container(
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
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Container(
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3.0, top: 5),
                                              child: Text(
                                                "${newsBody.content}",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
