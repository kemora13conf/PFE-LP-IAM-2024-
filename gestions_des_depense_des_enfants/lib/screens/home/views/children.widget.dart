import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/Config.dart';
import 'package:gestions_des_depense_des_enfants/models/http_response.model.dart';
import 'package:gestions_des_depense_des_enfants/screens/auth/controllers/register.controller.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/current_user.controller.dart';
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
        children = [];
        data.forEach((element) {
          // switch element from dynamic to Map<String, dynamic>
          Map<String, dynamic> child = element;
          EnfantModel enfant = EnfantModel.fromJson(child);
          setState(() {
            children.add(enfant);
          });
        });
      }
    }
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
        const SizedBox(height: 20),
        ListView.builder(
            shrinkWrap: true,
            itemCount: children.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  Get.toNamed("/child", arguments: children[index]);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  surfaceTintColor: MaterialStateProperty.all(Colors.white),
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  maximumSize: MaterialStateProperty.all(const Size(50, 50)),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(3),
                  ),
                  shadowColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Config.ASSETS_URL}/Children-images/${children[index].image}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Text("")),
              );
            }),
      ],
    );
  }
}
