import 'package:flutter/material.dart';

class ActiveBookingCard extends StatelessWidget {
  const ActiveBookingCard({
    Key? key,
    required this.userName,
    required this.bookingID,
    required this.bookingdate,
    required this.bookingPlan,
    required this.bookingPrice,
    required this.userID,
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
                'Booking ID - ${bookingID!}',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              ),
              Text(
                userName!,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Text(
                bookingdate!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                bookingPlan!,
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
                  '\$$bookingPrice!',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              const Text(
                '12 days remaining',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    width: 3.5,
                  ),
                  Text(
                    'Active',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
