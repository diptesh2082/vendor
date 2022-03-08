import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    Key? key,
    this.userName,
    this.bookingID,
    this.bookingdate,
    this.bookingPlan,
    this.bookingPrice,
    this.userID,
  }) : super(key: key);

  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;

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
                'Booking ID - $bookingID',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              ),
              Text(
                '$userName',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              //TODO: Add Booking Dates to the Text Widget
              const Text(
                "bookingdate",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '$bookingPlan',
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
                  '\$ $bookingPrice',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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
