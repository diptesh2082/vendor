import 'package:flutter/material.dart';
import 'package:vyam_vandor/Screens/order_details_screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:get/get.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key, this.otp, this.bookingID, this.userID})
      : super(key: key);

  final int? otp;

  final String? userID;
  final String? bookingID;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    print("The otp in booking screen is : ${widget.otp}");
    _controller = TextEditingController();
    super.initState();
  }

  TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Booking Summary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              //Container 1 for Booking Summary
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'Assets/Images/rect.png',
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Transformers Gym',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  Image.asset("Assets/Images/marker.png"),
                                  const SizedBox(
                                    width: 2.0,
                                  ),
                                  const Text(
                                    'Barakar',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              const SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  'Bus stand, Barvsdv',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Workout',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Package',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Start date',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Valid upto',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                'Gym- 3 months',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '3 months',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Feb 11, 2022',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'May 11, 2022',
                                style: TextStyle(
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
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Enter OTP',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xffC9C9C9),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () async {
                          //Function for Verifying OTP

                          if (int.parse(_controller!.text) == widget.otp) {
                            print("The otp is Verified");
                            Get.to(
                              const OrderDetails(),
                            );
                            await FirebaseFirestoreAPi()
                                .acceptandUpdatebookingStatus(
                                    widget.bookingID, widget.userID);
                          } else {
                            print("Invalid OTP");
                            Get.showSnackbar(GetSnackBar(
                              title: "Invalid OTP",
                              message: "Try it again",
                              isDismissible: true,
                              backgroundColor: Colors.black,
                            ));
                          }
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.bottomNaVBarTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ), //Container For payment
              const SizedBox(
                height: 10.0,
              ),
              //Container For Pricing
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$ 0.0',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3A3A3A),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Discount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$ 0.0',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3A3A3A),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Promo code',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Grand Total',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          '\$ 100.0',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //Container For Customer Details
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Customers Details',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3A3A3A)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Username: John Doe',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Phone Number: 078-66-555',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Payment Method : Cash',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
