import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homeservice/service/database.dart';


class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();


  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";
    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  Future<String> signUp({String email, String password, String username, String phonenumber}) async {
    try {

      var result= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await FirebaseAuth.instance.currentUser.updateProfile(displayName:user.displayName);
      user.updateProfile(displayName: username);
      await DatabaseService(uid: user.uid).updateUserData(email, password, username, phonenumber);
      print(user.uid);




    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUpService({String email, String password, String username, String phonenumber}) async {
    try {

      var result= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await FirebaseAuth.instance.currentUser.updateProfile(displayName:user.displayName);
      user.updateProfile(displayName: username);
      await DatabaseService(uid: user.uid).updateServiceData(email, password, username, phonenumber);
      print(user.uid);


    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  Future addBooking({String name, String phonenumber,String address, String notes, String title, String district, String time, String date, String userID, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addBooking(name, phonenumber, address, notes, title, district, time, date, user.uid, serviceID);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addHome({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addHome(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addCarpet({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addCarpet(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addGrass({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addGrass(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addPaint({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addPaint(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addSanitize({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addSanitize(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addVacuum({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addVacuum(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addWindow({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addWindow(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addWiring({String title,String district, String rate, String description, String serviceID}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser;
      await DatabaseService(uid: user.uid).addWiring(title, district, rate, description, user.uid);
      print(user.uid);

    }on FirebaseAuthException catch (e) {
      return e.message;
    }
  }




  Future<void> userSetup(String username ) async {
    CollectionReference user = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.toString();
    user.add({
      'displayName': username,
      'uid': uid
    });
    return;
  }
}