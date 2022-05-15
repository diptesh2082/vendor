// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_vandor/Screens/review.dart';
import 'package:vyam_vandor/Screens/sales/Sales.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/controllers/gym_controller.dart';
import 'package:vyam_vandor/sales/sales_main_page.dart';

import '../payment_history.dart';
// import 'package:vyam/Insights/payment_history.dart';

class AllTime extends StatefulWidget {
  const AllTime({Key? key}) : super(key: key);

  @override
  AllTimeState createState() => AllTimeState();
}

class AllTimeState extends State<AllTime> {
  final _auth = FirebaseAuth.instance;
  String totalBooking = '0';
  BookingController bookingController = Get.find<BookingController>();
  getDocumentsLength() async {
    await FirebaseFirestore.instance
        .collection('bookings')
         .where('vendorId', isEqualTo: gymId.toString())
         .where('booking_status',
        whereIn: ['upcoming', 'active', 'completed'])
        .snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        bookingController.booking.value=snapshot.docs.length;
        // setState(() {
        //   totalBooking = snapshot.docs.length.toString();
        // });
      }
      else if (snapshot.docs.isEmpty) {
        setState(() {
          totalBooking = 0.toString();
        });
      }
    });
   // await FirebaseFirestore.instance
   //      .collection('bookings')
   //      .where('vendorId', isEqualTo: gymId.toString())
   //      .where('booking_status',
   //     whereIn: ['upcoming', 'active', 'completed']).snapshots()
   //  .listen((snapshot) {
   //    if(snapshot.exists){
   //
   //    }
   //   setState(() {
   //     totalBooking = snapshot.docs.length.toString();
   //   }
   //  });


    // );
    //
    // print(totalBooking);
  }
  getRating()async{
    await FirebaseFirestore.instance.collection("Reviews")
        .where("gym_id",isEqualTo: gymId)
        .snapshots()
        .listen((snap) async {
      if (snap.docs.isNotEmpty){
        print("documentexist");

        var d=snap.docs;
        var b=0.0;
        var star1=0.0;
        var star2=0.0;
        var star3=0.0;
        var star4=0.0;
        var star5=0.0;
        Get.find<BookingController>().review_number.value=d.length;
        // var c=0.0;
        d.forEach((element) {
          b = b + double.parse(element["rating"]);
          if (double.parse(element["rating"])>4){
            star1=star1+1.0;
          }
          else if (double.parse(element["rating"])>3 && double.parse(element["rating"])<=4){
            star2=star2+1.0;
          }
          else if (double.parse(element["rating"])>2 && double.parse(element["rating"])<=3){
            star3=star3+1.0;
          }
          else if (double.parse(element["rating"])>1 && double.parse(element["rating"])<=2){
            star4=star4+1.0;
          }else{
            star5=star5+1.0;
          }


        });
        Get.find<BookingController>().star1.value= double.parse((star1/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star2.value= double.parse((star2/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star3.value= double.parse((star3/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star4.value= double.parse((star4/d.length).toStringAsFixed(1));
        Get.find<BookingController>().star5.value= double.parse((star5/d.length).toStringAsFixed(1));
        Get.find<BookingController>().review.value =double.parse((b/d.length).toStringAsFixed(1));
        print(Get.find<BookingController>().review.value);

        // getRatingCount(await Get.find<BookingController>().review.value);
      }

    });

  }

  @override
  void initState() {
    // print(_auth.currentUser!.email.toString());
    getRating();
    super.initState();
    getDocumentsLength();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product_details')
            .doc(gymId.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: 500,
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const Sales());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: HexColor("292F3D"),
                                ),
                                width: size.width * 0.45,
                                height: 290,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                             Text(
                                              "Sales",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Spacer(),
                                            // const SizedBox(
                                            //   width: 240,
                                            // ),
                                            Image.asset(
                                                "Assets/trend-down.png"),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                             Text(
                                              "₹ 100",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                         Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Total sales",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 42,
                                        ),
                                        Text(
                                          snapshot.data.get(
                                              'total_sales'), // DATABASE CALLLING FOR TOTAL SALES VALUE
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 54,
                                        ),
                                        Image.asset(
                                          "Assets/Vector 7.png",
                                          width: size.width * 0.4,
                                          fit: BoxFit.fitWidth,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Get.to( ()=>const TotalBookings());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: HexColor("292F3D"),
                                    ),
                                    width: size.width * 0.45,
                                    height: 135,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                 Text(
                                                  "Total bookings",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   width: 220,
                                                // ),
                                                Image.asset(
                                                    "Assets/trend-up.png"),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                 Text(
                                                  "8",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Obx(
                                                ()=> Text(
                                                bookingController.booking.value.toString(), //DATABASE CALLING FOR TOTAL BOOKING VALUE
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 35,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(()=>Review());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: HexColor("292F3D"),
                                    ),
                                    width: size.width * 0.45,
                                    height: 135,
                                    child: Obx(
                                        ()=> Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          child: Column(
                                            children:  [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Reviews",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 21,
                                              ),
                                              Text(
                                                "${Get.find<BookingController>().review_number.value}",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 35,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('product_details')
                              .doc(gymId.toString())
                              .snapshots(),
                          builder: (context,AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.data == null) {
                              return Container();
                            }
                            // int viewCount=snapshot.data!.get("view_count");
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 2.0, right: 2.0),
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: SizedBox(
                                  height: 63,
                                  child: Center(
                                    child: ListTile(
                                      title:  Text(
                                        '${snapshot.data.get("view_count")??""} Views',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            // fontFamily: 'PoppinsSemiBold',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      trailing: ImageIcon(
                                            AssetImage(
                                              "Assets/Images/Show.png",
                                          ),
                                        size: 30,
                                        )
                                    ),
                                  ),
                                )
                              ),
                            );
                          }
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 63,
                          child: GestureDetector(
                            onTap: () => Get.to(const PaymentHistory()),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8),
                                child: Row(
                                  children: const [
                                    Text(
                                      'View payment history',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
