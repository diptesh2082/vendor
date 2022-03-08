import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vyam_vandor/widgets/booking_card.dart';
import 'package:intl/intl.dart';

import '../widgets/active_booking.dart';

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

  Future updateGymStatusToFirestore({bool? isGymOpened}) async {
    try {
      //TODO: Change docID to logged in user ID
      _firestore
          .collection('product_details')
          .doc("mahtab5752@gmail.com")
          .update({
        "gym_status": isGymOpened!,
      });
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future getUpComingBookings() async {
    List<BookingCard> list = [];

    try {
      QuerySnapshot querysnapshot = await _firestore
          .collection('bookings')
          .where("vendorId", isEqualTo: "dipteshmandal555@gmail.com")
          .get();
      for (var snap in querysnapshot.docs) {
        if (snap.get("booking_status") == "u") {
          list.add(BookingCard(
            userName: snap.get("user_name"),
            userID: snap.get("userId"),
            bookingPrice: snap.get("booking_price"),
            bookingPlan: snap.get("booking_plan"),
            bookingID: snap.get("booking_id"),
            bookingdate: snap.get("booking_date").toString(),
          ));
        }
      }
      return list;
    } catch (e) {
      print(e);
    }
  }

  Future acceptUpCmingBookings({required String id}) async {
    try {
      print("The id Of Booking is : $id");
      await _firestore
          .collection('bookings')
          .doc('U4LcvYoV7dVi7wB5tt0o')
          .update(
        {
          'booking_status': 'a',
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future getUpActiveBookings() async {
    List<ActiveBookingCard> list = [];

    try {
      QuerySnapshot querysnapshot = await _firestore
          .collection('bookings')
          .where("vendorId", isEqualTo: "dipteshmandal555@gmail.com")
          .get();
      for (var snap in querysnapshot.docs) {
        if (snap.get("booking_status") == 'a') {
          list.add(ActiveBookingCard(
            userName: snap.get("user_name"),
            userID: snap.get("userId"),
            bookingPrice: snap.get("booking_price"),
            bookingPlan: snap.get("booking_plan"),
            bookingID: snap.get("booking_id"),
            bookingdate: DateFormat.yMMMd()
                .add_jm()
                .format(snap.get("booking_date").toDate()),
          ));
        }
      }

      return list;
    } catch (e) {
      print(e);
    }
  }

  Future updateLocationtoDatabase(
      double lat, double long, String pincode, String address) async {
    try {
      _firestore
          .collection('product_details')
          .doc(_firebaseAuth.currentUser!.email)
          .update(
        {
          "location": GeoPoint(lat, long),
          "pincode": pincode,
          "address": address
        },
      ).then((value) => print("Location is Updated to Database"));
    } catch (e) {
      print(e.toString());
    }
  }
}
