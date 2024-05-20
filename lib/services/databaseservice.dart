// DatabaseService.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  Future updateUserDataWithToken(String? token) async {
    return await userCollection.doc(uid).update({
      "deviceToken": token,
    });
  }

  Future savingUserData(
      String fullName,
      String email,
      String phoneNumber,
      String address,
      String bloodType,
      String medications,
      String medicationsText,
      String allergies,
      String allergiesText,
      String emergencyContact) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "address": address,
      "bloodType": bloodType,
      "medications": medications,
      "medicationsText": medicationsText,
      "allergies": allergies,
      "allergiesText": allergiesText,
      "emergencyContact": emergencyContact,
    });
  }
}
