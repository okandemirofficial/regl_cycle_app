import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regl_cycle_app/model/user.dart';
import 'package:regl_cycle_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  int? leftedDays;
  bool isLoading = false;

  ModelUser? modelUser; //*

  DateTime? start;
  DateTime? end;
  DateTime? newStartTime;
  Duration? difference;
  int? daysDifference;
  int? nextRegl;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap =
          await firebaseFirestore.collection("users").doc(widget.uid).get();
      var userData = userSnap.data() as Map<String, dynamic>;
      modelUser = ModelUser.fromMap(
          userData); //* burdan verileri firebaseden çekerken sorun yaşıyor. firebase e veriler gidiyor

      diffrentDates();
      startTimer();
      nextReglDate();
      setState(() {});
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  startTimer() {
    DateTime now = DateTime.now();
    if (end != null && now.isBefore(end!)) {
      Duration difference = end!.difference(now);
      setState(() {
        leftedDays = difference.inDays;
      });
    } else {
      setState(() {
        leftedDays = -1;
      });
    }
  }

  nextReglDate() {
    newStartTime = end!.add(const Duration(days: 20));
    DateTime now = DateTime.now();
    if (newStartTime != null && now.isBefore(newStartTime!)) {
      Duration difference = newStartTime!.difference(now);
      setState(() {
        nextRegl = difference.inDays;
      });
    } else {
      setState(() {
        nextRegl = 0;
      });
    }
  }

  diffrentDates() {
    Timestamp? startTimestamp = modelUser!.startTime;
    Timestamp? endTimestamp = modelUser!.endTime;
    start = startTimestamp!.toDate();
    end = endTimestamp!.toDate();
    difference = end!.difference(start!);
    //print("difference");
    daysDifference = difference!.inDays;

    setState(() {
      leftedDays = daysDifference;
    });
  }

  void updateSelectedDates(DateTimeRange dateTimeRange) async {
    await firebaseFirestore.collection("users").doc(widget.uid).update({
      'selectedDates': {
        'start': dateTimeRange.start,
        'end': dateTimeRange.end,
      },
    });
    var userSnap =
        await firebaseFirestore.collection("users").doc(widget.uid).get();
    var userData = userSnap.data() as Map<String, dynamic>;
    modelUser = ModelUser.fromMap(userData);
    
    selectedDates = dateTimeRange;
    diffrentDates();
    startTimer();
    nextReglDate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ProfileScreen(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    );
                  }),
                );
              },
              icon: const Icon(
                Icons.person,
                size: 40,
                color: Color(0xFFb298dc),
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            child: Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.09,
                margin: const EdgeInsets.only(top: 15, left: 15),
                padding: const EdgeInsets.all(15),
                child: Text(
                  modelUser?.username == null
                      ? "Loading"
                      : "Welcome Back     ${modelUser!.username}",
                  style: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                          fontSize: 25, color: Color(0xFFb298dc))),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
                color: Color(0xFFb298dc),
                borderRadius: BorderRadius.all(Radius.circular(300))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    leftedDays == null
                        ? "Create your first period"
                        : "${leftedDays == 0 ? 'Your period is over, get well soon' : '$leftedDays days left until your period ends'} ",
                    style: GoogleFonts.lobster(
                        textStyle: const TextStyle(
                            fontSize: 35, color: Colors.white))),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final DateTimeRange? dateTimeRange =
                          await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000));
                      if (dateTimeRange != null) {
                        updateSelectedDates(dateTimeRange);
                      }
                    },
                    child: Text("Edit Date",
                        style: GoogleFonts.lobster(
                            textStyle: const TextStyle(
                                fontSize: 25, color: Color(0xFFb298dc))))),
                const SizedBox(
                  height: 15,
                ),
                Text(
                    nextRegl == null
                        ? "Loading..."
                        : "Next period in $nextRegl days",
                    style: GoogleFonts.lobster(
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.white)))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 20),
            child: Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.09,
                margin: const EdgeInsets.only(top: 15, left: 15),
                padding: const EdgeInsets.all(15),
                child: Text(
                  daysDifference == null
                      ? "Loading..."
                      : "Last month your period lasts about $daysDifference days",
                  style: GoogleFonts.lobster(
                      textStyle: const TextStyle(
                          fontSize: 15, color: Color(0xFFb298dc))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
