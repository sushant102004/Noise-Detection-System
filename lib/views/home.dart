import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sensorOne = 0;
  int sensorTwo = 0;
  bool isDataLoaded = false;

  void getSensorsData() async {
    final ref = FirebaseDatabase.instance.ref();
    // ignore: unused_local_variable
    final sensorOneRef = ref.child('sensorOne').onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          sensorOne = snapshot.value as int;
          isDataLoaded = true;
        });
      }
      if (snapshot.value == 1) {
        playAudio();
      }
    });
    // ignore: unused_local_variable
    final sensorTwoRef = ref.child('sensorTwo').onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          sensorTwo = snapshot.value as int;
          isDataLoaded = true;
        });
      }
      if (snapshot.value == 1) {
        playAudio();
      }
    });
  }

  void resetDatabaseValues() async {
    DatabaseReference sensorOneRef = FirebaseDatabase.instance.ref('sensorOne');
    DatabaseReference sensorTwoRef = FirebaseDatabase.instance.ref('sensorTwo');
    sensorOneRef.set(0);
    sensorTwoRef.set(0);
  }

  playAudio() async {
    FlutterRingtonePlayer.playNotification();
  }

  void vibrateDevice() {
    Vibrate.vibrate();
  }

  Timer? timer;

  @override
  void initState() {
    getSensorsData();
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 5), (timer) => resetDatabaseValues());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: RichText(
            text: const TextSpan(
                text: "Noise ",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 19,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
                children: <TextSpan>[
              TextSpan(text: "Sensors", style: TextStyle(color: Colors.black))
            ])),
      ),
      body: isDataLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sensor 1
                    SensorStatusContainer(
                        size: _size,
                        // backgroundColor: Colors.grey.shade200,
                        backgroundColor:
                            sensorOne == 1 ? Colors.red : Colors.grey.shade200,
                        textColor: sensorOne == 1 ? Colors.white : Colors.black,
                        sensorNumber: '1'),
                    SizedBox(
                      height: _size.height / 7.3,
                      width: 10,
                    ),
                    // Sensor 2
                    SensorStatusContainer(
                        size: _size,
                        backgroundColor:
                            sensorTwo == 1 ? Colors.red : Colors.grey.shade200,
                        textColor: sensorTwo == 1 ? Colors.white : Colors.black,
                        sensorNumber: '2')
                  ],
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class SensorStatusContainer extends StatelessWidget {
  const SensorStatusContainer(
      {Key? key,
      required Size size,
      required this.backgroundColor,
      required this.sensorNumber,
      required this.textColor})
      : _size = size,
        super(key: key);

  final Size _size;
  final Color backgroundColor;
  final String sensorNumber;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.height / 7.3,
      width: _size.width / 3.3,
      child: Center(
        child: Text(
          sensorNumber,
          style:
              TextStyle(color: textColor, fontFamily: "Poppins", fontSize: 27),
        ),
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400, width: 1.4)),
    );
  }
}
