import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Screens/home__screen.dart';
import '../app_colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    this.userID,
    this.bookingID,
    this.imageUrl = "Assets/Images/rect.png",
  }) : super(key: key);

  final String? userID;
  final String? bookingID;
  final String? imageUrl;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('bookings')
                  .doc(widget.userID)
                  .collection('user_booking')
                  .doc(widget.bookingID)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    //Container 1 for Booking Summary
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('product_details')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot3) {
                                if (snapshot3.data == null) {
                                  return Container();
                                }
                                if (snapshot3.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                return FittedBox(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          widget.imageUrl!,
                                        ),
                                        const SizedBox(
                                          width: 15.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${snapshot.data!.get('gym_details')["name"]}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "Assets/Images/marker.png"),
                                                const SizedBox(
                                                  width: 2.0,
                                                ),
                                                Text(
                                                  snapshot3.data.get('landmark'),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  snapshot3.data.get('address'),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            height: 2,
                            color: Color(0xffE2E2E2),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            padding: const EdgeInsets.all(9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Workout',
                                      style:GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Package',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Start date',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Valid upto',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${snapshot.data.get('booking_plan')}',
                                      style:GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      DateFormat().format(snapshot.data
                                          .get('booking_date')
                                          .toDate()),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                                          .format(snapshot.data
                                              .get('booking_date')
                                              .toDate()),
                                      style:GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      DateFormat(DateFormat.YEAR_MONTH_DAY)
                                          .format(snapshot.data
                                              .get('plan_end_duration')
                                              .toDate()),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    //Container For TextField
                    //Container For payment
                    const SizedBox(
                      height: 10.0,
                    ),
                    //Container For Pricing
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 10,
                    //     horizontal: 10,
                    //   ),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(8.0)),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         'Payment',
                    //         style: GoogleFonts.poppins(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w700,
                    //           color: Colors.green,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10.0,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             'Total Amount',
                    //             style: GoogleFonts.poppins(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           Text(
                    //             '\$ ${snapshot.data.get('booking_price')}',
                    //             style: const TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w700,
                    //               color: Color(0xff3A3A3A),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           const Text(
                    //             'Discount',
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           Text(
                    //             '\$ ${snapshot.data.get('discount')}',
                    //             style: const TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w700,
                    //               color: Color(0xff3A3A3A),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const Text(
                    //         'Promo code',
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           const Text(
                    //             'Taxes and Charges',
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           Text(
                    //             '\$ ${snapshot.data.get('discount')}',
                    //             style: const TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w700,
                    //               color: Color(0xff3A3A3A),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           const Text(
                    //             'Grand Total',
                    //             style: TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w700,
                    //               color: Colors.green,
                    //             ),
                    //           ),
                    //           Text(
                    //             '\$ ${snapshot.data.get('grand_total')}',
                    //             style: const TextStyle(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w700,
                    //               color: Colors.green,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //Container For Customer Details
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('user_details')
                              .doc(widget.userID)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot2) {
                            if (snapshot2.data == null) {
                              return Container();
                            }
                            if (snapshot2.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             Text(
                                  'Customers Details',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Username: ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ' ${snapshot2.data.get("name")}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Phone Number: ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ' ${snapshot2.data.get('userId')}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Payment Method : ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ' Cash',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
