import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String email;
  final String uid;
  final String username;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final Map? selectedDates;

  ModelUser({
    required this.email,
    required this.uid,
    required this.username,
    this.startTime,
    this.endTime,
    this.selectedDates
  });

  static ModelUser fromMap(Map<String, dynamic> map) {
    return ModelUser(
      email: map['email'],
      uid: map["uid"],
      username: map['username'],
      selectedDates: map['selectedDates'],
      startTime: map['selectedDates']['start'],
      endTime: map['selectedDates']['end'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };
}
