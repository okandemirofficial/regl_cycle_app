import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataClass {
  final Map selectedDates;
  final Timestamp startTime;
  final Timestamp endTime;
  final String uid;
  final String username;

  const UserDataClass(
      {required this.selectedDates,
      required this.endTime,
      required this.startTime,
      required this.uid,
      required this.username});

  static fromMap(Map<String, dynamic> map) {
    return UserDataClass(
      selectedDates: map['selectedDates'],
      startTime: map['start'],
      endTime: map['end'],
      uid: map['uid'],
      username: map['username'],
    );
  }
}
