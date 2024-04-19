import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final String title;
  final String icon;
  const MainMenuButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          surfaceTintColor: MaterialStateProperty.all(Colors.white),
          minimumSize: MaterialStateProperty.all(const Size(60, 60)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0)),
          elevation: MaterialStateProperty.all(5),
        ),
        child: Container(
          width: 60,
          height: 60,
          child: Column(
            children: [
              Image.asset(
                icon,
                width: 30,
                height: 40,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontFamily: "Sen",
                ),
              ),
            ],
          ),
        ));
  }
}
