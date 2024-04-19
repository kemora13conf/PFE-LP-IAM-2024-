import 'package:flutter/material.dart';

class AddSolde extends StatelessWidget {
  final callBack;
  const AddSolde({super.key, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          callBack();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Container(
            alignment: Alignment.center,
            width: 180,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ajouter Solde",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sen",
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              ],
            )));
  }
}
