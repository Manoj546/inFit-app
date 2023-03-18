import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    home: FullScreenPage2(),
  ));
}
class FullScreenPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bpdiet.jpg'),//add image here
            fit: BoxFit.fill
        ),
      ),
    );
  }
}