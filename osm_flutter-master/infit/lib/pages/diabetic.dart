import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: FullScreenPage3(),
  ));
}

class FullScreenPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/diabeticdiet.jpg'),//Add image here
            fit: BoxFit.fill
        ),
      ),
    );
  }
}