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
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: _size.height / 7.3),
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
          SizedBox(
            height: _size.height / 3.7,
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
              height: _size.height / 16,
              width: _size.width / 3,
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
