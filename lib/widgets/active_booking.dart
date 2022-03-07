import 'package:flutter/material.dart';

class ActiveBookingCard extends StatelessWidget {
  const ActiveBookingCard({
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
            children: const [
              Text(
                'Booking ID - 22',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              ),
              Text(
                'John Doe',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Text(
                '07 Feb - 01 March',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Per Day',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  '\$ 20',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
