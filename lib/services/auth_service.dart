import 'package:firebase_auth/firebase_auth.dart';
import '../helper/helperfunction.dart';
import 'databaseservice.dart';
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password, String phoneNumber, String address,String bloodType,String medications,String medicationsText, String allergies,String allergiesText,String emergencyContact) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email,phoneNumber,address,bloodType,medications,medicationsText,allergies,allergiesText,emergencyContact);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}