import 'package:flutter/material.dart';

class AgreementText extends StatelessWidget {
  const AgreementText({super.key});
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white60,
          fontSize: 14.0,
        ),
        children: [
          TextSpan(
            text: 'By logging in or registering, you have agreed to the ',
          ),
          TextSpan(
            text: 'Terms and Conditions ',
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            // Add onTap handler to navigate to Terms and Conditions page
            // onTap: () {
            //   // Navigate to Terms and Conditions page
            // },
          ),
          TextSpan(
            text: 'and ',
          ),
          TextSpan(
            text: 'Privacy Policy.',
            style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            // Add onTap handler to navigate to Privacy Policy page
            // onTap: () {
            //   // Navigate to Privacy Policy page
            // },
          ),
        ],
      ),
    );
  }
}

// Usage:
// Use AgreementText widget wherever you want to display this agreement text.
// Example:
// AgreementText(),
