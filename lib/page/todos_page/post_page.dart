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

  Future getPostsData() async {
    final res = await postsService.getData(ServiseContants.posts);

    List<dynamic> listPostModel = jsonDecode(res);

    setState(() {
      userPostLists =
          listPostModel.map((user) => PostsModel?.fromJson(user)).toList();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await getPostsData();
                },
                child: const Text("yorumları getir"),
              ),
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
        Positioned(
          left: 340,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Text(circleId),
          ),
        ),
      ],
    );
  }
}
