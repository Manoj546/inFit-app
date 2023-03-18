import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: FullScreenPage1(),
  ));
}
class FullScreenPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/gen1.jpg'),//Add image here
              fit: BoxFit.fill
          ),
        ),
      ),


    );
  }
}