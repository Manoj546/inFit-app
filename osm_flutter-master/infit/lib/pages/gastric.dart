import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: FullScreenPage4(),
  ));
}
class FullScreenPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/gastricdiet.jpeg'),//Add image here
            fit: BoxFit.fill
        ),
      ),
    );
  }
}