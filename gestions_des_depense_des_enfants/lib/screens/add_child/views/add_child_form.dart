import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestions_des_depense_des_enfants/screens/add_child/controllers/add_child.controller.dart';
import 'package:get/get.dart';

class AddChildForm extends StatelessWidget {
  const AddChildForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    // go back button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 30, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Image(
                              image: AssetImage('assets/icons/back.png'),
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Ajouter un enfant",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Sen",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Upload photo button
                          GetBuilder<AddChildController>(builder: (_) {
                            return Stack(
                              children: [
                                _.image.isEmpty
                                    ? Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(75),
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          size: 100,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          image: DecorationImage(
                                            image: Image.file(
                                              File(_.image.value),
                                            ).image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _.pickImage();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C63FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),

                          const SizedBox(height: 20),
                          // IMAGE ERROR
                          GetBuilder<AddChildController>(
                            builder: (_) => _.imageError.value.isEmpty
                                ? const SizedBox()
                                : Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _.imageError.value,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
