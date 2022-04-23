import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sensorOne = "";
  String sensorTwo = "";
  bool isDataLoaded = false;
  String noiseDetected = "";

  void getSensorsData() async {
    final ref = FirebaseDatabase.instance.ref();
    // ignore: unused_local_variable
    final sensorOneRef = ref.child('sensorOne').onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          sensorOne = snapshot.value.toString();
          isDataLoaded = true;
        });
      } else {
        setState(() {
          sensorOne = "Error In Database";
        });
      }
    });
    // ignore: unused_local_variable
    final sensorTwoRef = ref.child('sensorTwo').onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          sensorTwo = snapshot.value.toString();
          isDataLoaded = true;
        });
      } else {
        setState(() {
          sensorTwo = "Error In Database";
        });
      }
    });
  }

  @override
  void initState() {
    getSensorsData();
    super.initState();
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
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: isDataLoaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sensor 1
                    Column(
                      children: [
                        SensorStatusContainer(
                            size: _size,
                            // backgroundColor: Colors.grey.shade200,
                            backgroundColor: sensorOne == 'noiseDetected'
                                ? Colors.red
                                : Colors.grey.shade200,
                            textColor: sensorOne == 'noiseDetected'
                                ? Colors.white
                                : Colors.black,
                            sensorNumber: '1'),
                        Text(
                          sensorOne == 'noiseDetected'
                              ? "Noise Detected!"
                              : noiseDetected,
                          style: const TextStyle(
                              fontFamily: "Poppins", color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _size.height / 7.3,
                      width: 10,
                    ),
                    // Sensor 2
                    Column(
                      children: [
                        SensorStatusContainer(
                            size: _size,
                            backgroundColor: sensorTwo == 'noiseDetected'
                                ? Colors.red
                                : Colors.grey.shade200,
                            textColor: sensorTwo == 'noiseDetected'
                                ? Colors.white
                                : Colors.black,
                            sensorNumber: '2'),
                        Text(
                          sensorTwo == 'noiseDetected'
                              ? "Noise Detected!"
                              : noiseDetected,
                          style: const TextStyle(
                              fontFamily: "Poppins", color: Colors.red),
                        ),
                      ],
                    )
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
