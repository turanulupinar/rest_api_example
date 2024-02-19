import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_example/page/album_page/album_model.dart';
import 'package:rest_api_example/service/base_service.dart';

import '../../constant/service_constants.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  List<AlbumModel> albumsList = [];
  BaseService albumService = BaseService();
  getAlbumsData() async {
    final res = await albumService.getData(ServiseContants.albums);

    List<dynamic> albumsData = jsonDecode(res);
    albumsList = albumsData.map((user) => AlbumModel.fromJson(user)).toList();

    setState(() {});
  }

  @override
  void initState() {
    getAlbumsData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: 400,
            child: ListView.builder(
                itemCount: albumsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(albumsList[index].title.toString()));
                }),
          )
        ],
      ),
    );
  }
}
