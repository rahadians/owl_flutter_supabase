import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:owl_flutter/app/assets/models/constant.dart';
import 'package:owl_flutter/app/assets/models/newsmodel.dart';
import 'package:owl_flutter/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/readme_news_controller.dart';

class ReadmeNewsView extends GetView<ReadmeNewsController> {
  var newsBody = Get.arguments;
  // final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.title.value = newsBody[0]["title"];
    controller.content.value = newsBody[0]["content"];
    controller.idNews.value = newsBody[0]["id_news"];

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Container(
                      padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                      color: kLightgreen.withOpacity(0.5),
                      child: Text(
                        "${newsBody[0]["title"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    // background: Image.network('${controller.imgUrl}+${controller.newModelImg} ',fit: BOxfit.cover),
                  ),
                  backgroundColor: kLightgreen,
                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                )
              ];
            }),
            body: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Content",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "${newsBody[0]["content"]}",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "${newsBody[0]["description"]}",
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            Routes.EDITNEWS,
                            // arguments: [
                            //   {
                            //     "title": newsBody.title,
                            //     "content": newsBody.content,
                            //     "idnews": newsBody.idNews.toString()
                            //   },
                            // ],
                          );
                        },
                        child: Icon(Icons.edit),
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Icon(Icons.delete_forever))
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
