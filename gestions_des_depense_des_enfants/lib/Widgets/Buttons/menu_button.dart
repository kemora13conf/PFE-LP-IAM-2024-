import 'package:flutter/material.dart';
import 'package:gestions_des_depense_des_enfants/screens/home/controllers/side_bar.controller.dart';
import 'package:get/get.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggle() {
    if (Get.find<SideBarController>().isCollapsed.value) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    Get.find<SideBarController>().toggle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.white30,
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: GetBuilder<SideBarController>(
          builder: (controller) {
            return IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _animation,
                color: Colors.black,
              ),
              onPressed: _toggle,
            );
          },
        ));
  }
}
