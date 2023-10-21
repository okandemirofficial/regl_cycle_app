import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  final String email;
  final String uid;
  final String username;

  const ModelUser({
    required this.email,
    required this.uid,
    required this.username,
  });

  static ModelUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ModelUser(
        email: snapshot['email'],
        uid: snapshot["uid"],
        username: snapshot['username']);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };
}
