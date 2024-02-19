import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_example/constant/service_constants.dart';
import 'package:rest_api_example/page/todos_page/post_model.dart';
import 'package:rest_api_example/service/base_service.dart';

class PostsPageView extends StatefulWidget {
  const PostsPageView({super.key});

  @override
  State<PostsPageView> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostsPageView> {
  BaseService postsService = BaseService();
  List<PostsModel> userPostLists = [];
  bool isLoading = false;
  Future getPostsData() async {
    setState(() {
      isLoading = true;
    });
    final res = await postsService.getData(ServiseContants.posts);

    List<dynamic> listPostModel = jsonDecode(res);

    userPostLists =
        listPostModel.map((user) => PostsModel?.fromJson(user)).toList();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Todo List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () async {
                await getPostsData();
              },
              child: isLoading
                  ? const Text("Yorumları Getiriliyor..")
                  : const Text("Yorumları Getir"),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(userPostLists.length, (index) {
                    PostsModel postList = userPostLists[index];
                    return Padding(
                        padding: const EdgeInsets.all(12),
                        child: CustomCard(
                            circleId: postList.userId.toString(),
                            subtitle: postList.body.toString(),
                            title:
                                " ${postList.id.toString()}.  ${postList.title.toString()}"));
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.circleId,
      required this.subtitle,
      required this.title});

  final String circleId;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 400,
          child: Card(
            color: Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: false,
                      // ,
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white70),
                    )
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 12),
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Text(circleId),
            ),
          ),
        ),
      ],
    );
  }
}
