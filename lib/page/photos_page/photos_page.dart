import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_example/constant/service_constants.dart';
import 'package:rest_api_example/page/photos_page/photo_model.dart';

import 'package:rest_api_example/service/base_service.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  final _baseService = BaseService();
  List<PhotoModel> photoList = [];
  bool isLoading = false;
  // @override
  // void initState() {
  //   getUserData();
  //   super.initState();
  // }

  getPhotoData() async {
    setState(() {
      photoList.clear();
      isLoading = true;
    });

    final res = await _baseService.getData(ServiseContants.photos);

    List<dynamic> photosData = jsonDecode(res);

    setState(() {
      photoList = photosData.map((user) => PhotoModel.fromJson(user)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Photo Gallery"),
      ),
      body: Column(children: [
        ElevatedButton.icon(
            icon: isLoading == false
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )),
            onPressed: () async {
              await getPhotoData();
            },
            label: const Text("Get Data")),
        Expanded(
            child: ListView.builder(
                itemCount: photoList.length,
                itemBuilder: (context, index) {
                  final photo = photoList[index];
                  return Container(
                    width: double.maxFinite,
                    height: 250,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            photo.url ?? "",
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Text(photo.title ?? "")
                        ]),
                  );
                }))
      ]),
    );
  }
}
