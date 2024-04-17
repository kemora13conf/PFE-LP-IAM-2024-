import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  int _index = 0;


  get index => _index;


  void next() {
    if (_index < 2) {
      _index++;
      
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      update();
    }
  }

  void previous() {
    if (_index > 0) {
      _index--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      update();
    }
  }

  void goTo(int i) {
    if (i >= 0 && i <= 2) {
      _index = i;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      update();
    }
  }
  
}
