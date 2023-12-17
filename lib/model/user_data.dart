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

  /// {
  ///       "selectedDates" : {},
  ///       "start" : 30924823094320,
  ///       "end" : 293480293849032,
  ///       "uid" : "sdfklfnmkebmkmksemkmek",
  ///       "username" : "username"
  /// }

  /// ESKI MODEL
  /// {
  ///   "gender" : "kadin"
  ///   "email" : "me@okandemir.net",
  ///   "username" : "okan3358"
  ///   "uid" : "sdlkfmekkesklbmklbmlke",
  ///     "selectedDates" : {
  ///          "start" : 029348290340923
  ///           "end" : 029348290340923
  ///      }
  /// }
}
