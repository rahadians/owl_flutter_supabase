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
  final HomeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(Routes.ADDNEWS);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.HOME);
              },
              icon: Icon(Icons.list_alt_outlined)),
          // SizedBox(
          //   width: 5,
          // ),
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.HOME_GRID_VIEW);
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
            future: HomeC.getNewsData(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Obx(() => (HomeC.allNewsData.length == null)
                  ? Center(
                      child: Text(
                        "Data Tidak Ada",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => HomeC.getNewsData(),
                      child: (HomeC.isloading.value)
                          ? CircularProgressIndicator()
                          // : Text("loading")
                          : GridView.builder(
                              gridDelegate:
                                  // SliverGridDelegateWithFixedCrossAxisCount(
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                // crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                // crossAxisSpacing: 5,
                                // mainAxisSpacing: 5
                              ),
                              itemCount: HomeC.allNewsData.length,
                              itemBuilder: (context, index) {
                                TableNews newsBody = HomeC.allNewsData[index];

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
                                      color: kLightgreen,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 175,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "${newsBody.imageUrl}",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, top: 3),
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
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


//                                     height: 100,
//                                         width: double.infinity,     
//                                               child:
                                

//                                       color: Colors.amber[100],
//                                       child: Column(children: [
//  Align(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     child: Text(
//                                                       "${newsBody.title} ",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           fontSize: 20),
//                                                     ),
//                                                   ),
                                             
//                                                 ),
                                               
//                                       ]
                                      
                                      // ),

                                      // child: Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.start,
                                      //   children: [
                                      //     Container(
                                      //         height: 100,
                                      //         width: 100,
                                      //         child: Image.network(
                                      //           "${newsBody.imageUrl}",
                                      //           fit: BoxFit.fill,
                                      //         ),
                                      //         color: Colors.transparent),
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           left: 10.0,
                                      //           bottom: 2,
                                      //           right: 2),
                                      //       child: Column(
                                      //         children: [
                                      //           Container(
                                      //             child: Align(
                                      //               alignment:
                                      //                   Alignment.centerLeft,
                                      //               child: Text(
                                      //                 "${newsBody.title} ",
                                      //                 style: TextStyle(
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     fontSize: 20),
                                      //               ),
                                      //             ),
                                      //             height: 30,
                                      //             width: 250,
                                      //           ),
                                      //           SizedBox(
                                      //             height: 1,
                                      //           ),
                                      //           Expanded(
                                      //             child: Container(
                                      //               width: 250,
                                      //               child: Text(
                                      //                   "${newsBody.content}"),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),