
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:rest_api_example/page/post_page/models/request_post_model.dart';
import 'package:rest_api_example/page/post_page/models/response_post_model.dart';
import 'package:rest_api_example/page/todos_page/post_model.dart';


import 'post_page_view_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostPage> {
  List<PostsModel> userPostLists = [];
  ResponsePostModel? myResponsePostModel;
  final PostPageViewModel _viewModel = PostPageViewModel();
  bool isLoading = false;

  final myPostModel =
      RequestPostModel(title: "Test1", body: "Test", userId: 123);

  Future getPostsData() async {
    setState(() {
      isLoading = true;
    });
    myResponsePostModel = await _viewModel.postData(myPostModel);

    setState(() {
      isLoading = false;
    });
  }

  Future updateData() async {
    setState(() {
      isLoading = true;
    });
    myResponsePostModel = await _viewModel.putData(myPostModel);
    log(myResponsePostModel.toString());
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Post API Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await getPostsData();
                  },
                  child: isLoading
                      ? const Text("Gönderiliyor..")
                      : const Text("Gönder"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await updateData();
                  },
                  child: isLoading
                      ? const Text("Veri güncellinyor..")
                      : const Text("Güncelle"),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (myResponsePostModel?.success == false)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          myResponsePostModel?.errorMessage.toString() ??
                              "null"),
                    ),
                  ListTile(
                    onTap: () async {
                      final result = await _viewModel.postDelete(1);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(result)));
                    },
                    leading: Text(myResponsePostModel?.id.toString() ?? ""),
                    title: Text(myResponsePostModel?.title ?? ""),
                    subtitle: Text(myResponsePostModel?.body ?? ""),
                    trailing:
                        Text(myResponsePostModel?.userId.toString() ?? ""),
                  )
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
