import 'package:flutter/material.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 25)),
          Column(
            children: [
              Image.network(
                  "https://kristinmcgee.com/wp-content/uploads/2017/04/Y1D_8267.jpg"),
              const Text(
                "Enjoy our APP anytime",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'proxima',
                    height: 1.2,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Access your personalized yoga\n courses anytime anywhere",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text("Get Started"))
            ],
          )
        ],
      )),
    );
  }
}
