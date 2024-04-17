import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/routes/paths.dart';
import 'package:gestions_des_depense_des_enfants/screens/welcome/items.dart';
import 'package:gestions_des_depense_des_enfants/screens/welcome/welcome.controller.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    WelcomeController controller = Get.find();
    // List<Widget> items = [item1(), item2(), item3()];
    return Scaffold(
        body: Stack(
      children: [
        const Image(
          image: AssetImage('assets/splash/splash_background.png'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 130.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: (index) => controller.goTo(index),
                        children: [
                          Items.item1(),
                          Items.item2(),
                          Items.item3(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 50.0, left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetBuilder<WelcomeController>(
                              builder: (_) => controller.index == 2
                                  ? const SizedBox()
                                  : TextButton(
                                      onPressed: () {
                                        Get.offNamed(Paths.AUTH);
                                      },
                                      child: const Text(
                                        "Skip",
                                        style: TextStyle(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    )),
                          indicators(),
                          GetBuilder<WelcomeController>(
                            builder: (_) => controller.index == 2
                                ? const SizedBox(height: 48)
                                : TextButton(
                                    onPressed: () {
                                      controller.next();
                                    },
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        )
      ],
    ));
  }

  Widget indicators() {
    return GetBuilder<WelcomeController>(
      builder: (e) {
        return Row(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                e.goTo(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: e.index == index ? 30 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: e.index == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
