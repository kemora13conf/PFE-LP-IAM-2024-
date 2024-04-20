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
          child: SingleChildScrollView(
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
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Full Name *",
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<AddChildController>(
                                builder: (_) => TextField(
                                      onChanged: _.onNameChanged,
                                      decoration: const InputDecoration(
                                        hintText: 'Ex: Abdelghani El Mouak',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 20,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Color(0xFFA1A1A1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )),
                            GetBuilder<AddChildController>(
                              builder: (_) => _.nameError.value.isNotEmpty
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _.nameError.value,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 10),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "CNE *",
                                  style: TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<AddChildController>(
                                builder: (_) => TextField(
                                      onChanged: _.onCneChanged,
                                      decoration: const InputDecoration(
                                        hintText: 'Ex: G131089681',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 20,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Color(0xFFA1A1A1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    )),
                            GetBuilder<AddChildController>(
                              builder: (_) => _.cneError.value.isNotEmpty
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _.cneError.value,
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 10),
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Gender *",
                                    style: TextStyle(
                                      color: Color(0xFF374151),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                            GetBuilder<AddChildController>(
                              builder: (_) => DropdownButtonFormField<String>(
                                value: _.gender.value,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    )),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    _.onGenderChanged(value);
                                  }
                                },
                                items: <String>['Male', 'Female']
                                    .map((String gender) {
                                  return DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Ecole *",
                                    style: TextStyle(
                                      color: Color(0xFF374151),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                            GetBuilder<AddChildController>(
                              builder: (_) => DropdownButtonFormField<String>(
                                value: _.ecole.value,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    )),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    _.onEcoleChanged(value);
                                  }
                                },
                                items: <String>[
                                  'Razi',
                                  'Ibn Tofail',
                                  'Ibn Rochd'
                                ].map((String ecole) {
                                  return DropdownMenuItem<String>(
                                    value: ecole,
                                    child: Text(ecole),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Niveau *",
                                    style: TextStyle(
                                      color: Color(0xFF374151),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                            GetBuilder<AddChildController>(
                              builder: (_) => DropdownButtonFormField<String>(
                                value: _.niveau.value,
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA1A1A1),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    )),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    _.onNiveauChanged(value);
                                  }
                                },
                                items: <String>[
                                  '1ere annee',
                                  '2eme annee',
                                  '3eme annee',
                                  '4eme annee',
                                  '5eme annee',
                                ].map((String niveau) {
                                  return DropdownMenuItem<String>(
                                    value: niveau,
                                    child: Text(niveau),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GetBuilder<AddChildController>(builder: (_) {
                              return _.isLoading.isTrue
                                  ? Container(
                                      padding: const EdgeInsets.all(10.0),
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 0, 120, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 4.0,
                                          strokeAlign:
                                              BorderSide.strokeAlignInside,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _.submit();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF6C63FF),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: const Text(
                                            "Add Child",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: 'Sen',
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            }),
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
      ),
    );
  }
}
