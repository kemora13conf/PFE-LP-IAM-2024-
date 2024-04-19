import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gestions_des_depense_des_enfants/models/enfant.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildrenWidget extends StatefulWidget {
  const ChildrenWidget({super.key});

  @override
  State<ChildrenWidget> createState() => _ChildrenWidgetState();
}

class _ChildrenWidgetState extends State<ChildrenWidget> {
  late List<EnfantModel> children;

  Future<void> getChildren() async {
    children = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    final response = await http.get(
      Uri.parse(Config.API_URL + "/enfants"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      HttpResponseModel res =
          HttpResponseModel.fromJson(jsonDecode(response.body));
      if (res.type == "ENFANTS_FETCHED") {
        List<dynamic> data = res.data;
        data.forEach((element) {
          // switch element from dynamic to Map<String, dynamic>
          Map<String, dynamic> child = element;
          EnfantModel enfant = EnfantModel.fromJson(child);
          children.add(enfant);
        });
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: const Text(
            textAlign: TextAlign.start,
            "Mes Enfants",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: const Text(
            textAlign: TextAlign.start,
            "Clicker sur l’enfant pour voir son profils",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 10),
        children.length > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.toNamed(Paths.ADD_CHILD);
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 35,
                                  ))),
                          const SizedBox(height: 5),
                          const Text(
                            "Ajouter enfant",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    ...children.map((enfant) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/child", arguments: enfant);
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Image(
                                    image: NetworkImage(
                                        "${Config.ASSETS_URL}/Children-images/${enfant.image}"),
                                  )),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 50,
                              child: Text(
                                enfant.fullname!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ])
            : const Text("Vous n'avez pas encore d'enfants"),
      ],
    );
  }
}
