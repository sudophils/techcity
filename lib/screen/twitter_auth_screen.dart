import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterAuthScreen extends StatefulWidget {
  const TwitterAuthScreen({super.key});

  @override
  State<TwitterAuthScreen> createState() => _TwitterAuthScreenState();
}

class _TwitterAuthScreenState extends State<TwitterAuthScreen> {
  @override
  Widget build(BuildContext context) {
    /// we create the twitter logo
    Widget buildTwitterLogo() {
      return const Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Icon(
              FontAwesomeIcons.twitter,
              size: 70,
              color: Colors.white,
            )),
      );
    }

    /// we created a re-usable spacer so we don't need to create one everytime
    Widget verticalSpace({double value = 10.0}) {
      return SizedBox(
        height: value,
      );
    }

    Widget buildButton({required String label, required bool showBg}) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              color: showBg ? Colors.white : Colors.transparent,
              border: showBg ? null : Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          width: 200,
          height: 45,
          child: Center(
              child: Text(label,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: showBg ? Colors.blueAccent : Colors.white))),
        ),
      );
    }

    Widget buildFingerPrint() {
      return const Center(
        child: Icon(
          Icons.fingerprint,
          size: 120,
          color: Colors.white,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blueAccent.withOpacity(0.8),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            // twitter logo here
            buildTwitterLogo(),

            /// added the header of the screens
            const Text(
              'See whats happening in \nthe world right now',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),

            verticalSpace(value: 50),

            /// add the buttons for signup and login
            buildButton(label:'Signup',showBg: true),
            verticalSpace(value: 16),
            buildButton(label:'Login', showBg:false),

            verticalSpace(value: 24), // give space

            /// create the 'OR"
            const Text(
              'OR',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            verticalSpace(value: 24), // give space
            const Text(
              'Login with Touch ID',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),

            verticalSpace(value: 24), // give space

            /// build fingerprint function
            buildFingerPrint()
          ],
        ),
      ),
    );
  }
}
