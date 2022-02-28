import 'package:geolocator/geolocator.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';

class LocationApi {
  Future getLocation() async {
    try {
      print("Getting Location from Geolocator");
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final lat = position.latitude;
      final long = position.longitude;
      print(position.latitude);
      print(position.longitude);

      await FirebaseFirestoreAPi().updateLocationtoDatabase(
        lat,
        long,
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
