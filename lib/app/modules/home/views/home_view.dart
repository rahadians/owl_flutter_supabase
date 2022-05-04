import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';
import 'package:owl_flutter/app/assets/models/newsmodel.dart';
import 'package:owl_flutter/app/assets/models/readnews.dart';
import 'package:owl_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:owl_flutter/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADDNEWS);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        toolbarHeight: 20,
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
              // ignore: unnecessary_null_comparison
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
                                NewsModel newsBody =
                                    controller.allNewsData[index];

                                return InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.README_NEWS, arguments: [
                                      {
                                        "title": newsBody.title,
                                        "content": newsBody.content,
                                        "description": newsBody.description,
                                        "id_news": newsBody.idNews.toString()
                                      },
                                    ]);
                                  },
                                  child: ListTile(
                                      leading: CircleAvatar(
                                          child: Image.network(
                                            'https://picsum.photos/250?image=9',
                                            fit: BoxFit.cover,
                                          ),
                                          backgroundColor: Colors.blue),
                                      title: Text("${newsBody.title}"),
                                      subtitle: Text("${newsBody.content}"),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {},
                                      )),
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
