import 'package:flutter/cupertino.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("Techcity",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 38,
            )),
        Image.asset(
          "assets/images/tech_city_logo.png",
          width: 55,
        )
      ],
    );
  }
}
