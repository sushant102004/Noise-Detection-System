import 'package:flutter/material.dart';
import 'package:noise_detection_app/views/home.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Image.asset("assets/images/splashImage.png"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: const TextSpan(
                      text: "Noise ",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 32,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                    TextSpan(
                        text: "Detection",
                        style: TextStyle(color: Colors.black))
                  ])),
            ],
          ),
          const Text(
            "Detect noise in silent places instantly.",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 230,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const HomePage()));
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              "Developed By Team Name",
              style: TextStyle(
                  color: Colors.black, fontFamily: "Poppins", fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
