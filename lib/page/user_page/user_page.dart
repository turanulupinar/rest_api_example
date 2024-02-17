import 'dart:convert';
 

import 'package:flutter/material.dart';
import 'package:rest_api_example/constant/service_constants.dart';
import 'package:rest_api_example/page/user_page/user_model.dart';
import 'package:rest_api_example/service/base_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _baseService = BaseService();
  List<UserModel> userList = [];
  bool isLoading = false;
  // @override
  // void initState() {
  //   getUserData();
  //   super.initState();
  // }

  getUserData() async {
    setState(() {
      userList.clear();
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    final res = await _baseService.getData(ServiseContants.users);

    List<dynamic> userModel = jsonDecode(res);

    setState(() {
      userList = userModel.map((user) => UserModel.fromJson(user)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
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
              await getUserData();
            },
            label: const Text("Get Users")),
        Expanded(
            child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return ListTile(
                    leading: Text(user.id.toString()),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email ?? ""),
                        Text(user.company?.name ?? ""),
                      ],
                    ),
                    title: Text(user.name ?? "null"),
                  );
                }))
      ]),
    );
  }
}
