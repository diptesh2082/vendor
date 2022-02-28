import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreAPi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> checkIslocationAlreadyUpdated() async {
    try {
      print(_firebaseAuth.currentUser!.email);
      print("///////////");
      DocumentSnapshot res = await _firestore
          .collection('product_details')
          .doc(_firebaseAuth.currentUser!.email)
          .get();
      GeoPoint location = await res.get("location");
      print(location.latitude);
      print(location.longitude);
      if (location.latitude.toString().isNotEmpty &&
          location.longitude.toString().isNotEmpty) {
        return true;
      } else {
        print("No Location in Database");
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future updateLocationtoDatabase(double lat, double long) async {
    try {
      _firestore
          .collection('product_details')
          .doc(_firebaseAuth.currentUser!.email)
          .update(
        {
          "location": GeoPoint(lat, long),
        },
      ).then((value) => print("Location is Updated to Database"));
    } catch (e) {
      print(e.toString());
    }
  }
}
