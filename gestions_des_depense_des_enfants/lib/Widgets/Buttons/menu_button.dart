import 'dart:math';

import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {
  bool menuOpened = false;
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

    _controller.addListener(() {
      setState(() {});
    });
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
              color: Colors.black26,
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (menuOpened) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            setState(() {
              menuOpened = !menuOpened;
            });
          },
          child: Column(
            mainAxisAlignment: !menuOpened
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    alignment: Alignment.center,
                    angle: _animation.value * 0.25 * pi,
                    child: Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox()),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    alignment: Alignment.center,
                    angle: _animation.value * -0.25 * pi,
                    origin: Offset(!menuOpened ? 0 : -5, 0),
                    child: Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SizedBox()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
