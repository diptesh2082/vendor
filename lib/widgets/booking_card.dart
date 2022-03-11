import 'package:flutter/material.dart';
import 'package:vyam_vandor/Screens/booking_summary_screen.dart';
import 'package:get/get.dart';

class BookingCard extends StatefulWidget {
  const BookingCard(
      {Key? key,
      this.userName = "",
      this.bookingID = "",
      this.bookingdate = "",
      this.bookingPlan = "",
      this.bookingPrice = 0.0,
      this.userID = "",
      this.bookings,
      required this.otp})
      : super(key: key);

  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;
  final int? otp;
  final Map? bookings;

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Booking ID - ${widget.bookingID}',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              ),
              Text(
                '${widget.userName}',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              //TODO: Add Booking Dates to the Text Widget
              Text(
                widget.bookingdate!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '${widget.bookingPlan}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  '\$ ${widget.bookingPrice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("The otp for booking is : ");
                  print(widget.otp);
                  Get.to(
                    () => BookingScreen(
                      otp: widget.otp,
                      bookingID: widget.bookingID,
                      userID: widget.userID,
                    ),
                    arguments: {
                      "otp_pass": widget.otp,
                    },
                  );
                  // try {
                  //   print(widget.bookingID!);
                  //   await FirebaseFirestoreAPi()
                  //       .acceptUpCmingBookings(id: widget.bookingID!);
                  //   FirebaseFirestoreAPi().getUpActiveBookings();
                  //   FirebaseFirestoreAPi().getUpComingBookings();
                  // } catch (e) {
                  //   print(e);
                  // }
                },
                child: const Text(
                  'Accept',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.green,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 5,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
