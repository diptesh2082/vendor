import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/Screens/login_screen.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:vyam_vandor/provider/firebase_streams_docs.dart';
import 'package:get/get.dart';
import '../../widgets/active_booking.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/drawer_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/past_bookings.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var status = true;
  final GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

  bool showBranches = false;

  @override
  void initState() {
    super.initState();
  }

  bool isHeightTobeIncreased = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: FirebaseCollectionAndDocsApi().gymDetails,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                Scaffold(
                  key: _drawerkey,
                  backgroundColor: AppColors.backgroundColor,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      // FirebaseFirestoreAPi().updateTokenToFirebase();
                      FirebaseFirestoreAPi().checkTokenChange();
                    },
                  ),
                  appBar: buildAppBar(
                    context,
                    isGymOpened: snapshot.data!.get("gym_status"),
                    gymLocation: snapshot.data!.get("landmark"),
                    gymname: snapshot.data!.get("name"),
                    leadingCallback: () {
                      if (showBranches == false) {
                        _drawerkey.currentState!.openDrawer();
                      }
                    },
                  ),
                  drawer: buildDrawer(context),
                  body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      children: [
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            //Upcoming Bookings Cards
                            ExpansionTile(
                              title: const Text('Upcoming Bookings'),
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collectionGroup('user_booking')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snap) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (snap.data == null) {
                                      return const Text("No Active Bookings");
                                    }

                                    var doc = snap.data.docs;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: doc.length,
                                      itemBuilder: (context, index) {
                                        if (doc[index]['booking_status'] ==
                                            'upcoming') {
                                          return BookingCard(
                                            userID: doc[index]['userId'] ?? "",
                                            userName:
                                                doc[index]['user_name'] ?? "",
                                            bookingID:
                                                doc[index]['booking_id'] ?? "",
                                            bookingPlan: doc[index]
                                                    ['booking_plan'] ??
                                                "",
                                            bookingPrice: doc[index]
                                                    ['booking_price'] ??
                                                "",
                                            bookingdate: doc[index]
                                                    ['booking_date'] ??
                                                "",
                                            otp: doc[index]['otp_pass'],
                                          );
                                        }
                                        return Container();
                                      },
                                    );
                                  },
                                )
                              ],
                            ),

                            ///Active Booking Cards
                            ExpansionTile(
                              title: const Text('Active Bookings'),
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collectionGroup('user_booking')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snap) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (snap.data == null) {
                                      return const Text("No Active Bookings");
                                    }
                                    var doc = snap.data.docs;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: doc.length,
                                      itemBuilder: (context, index) {
                                        if (doc[index]['booking_status'] ==
                                                'active' &&
                                            doc[index]['booking_accepted'] ==
                                                true) {
                                          return ActiveBookingCard(
                                            userID: doc[index]['userId'] ?? "",
                                            userName:
                                                doc[index]['user_name'] ?? "",
                                            bookingID:
                                                doc[index]['booking_id'] ?? "",
                                            bookingPlan: doc[index]
                                                    ['booking_plan'] ??
                                                "",
                                            bookingPrice: doc[index]
                                                    ['booking_price'] ??
                                                "",
                                            bookingdate: doc[index]
                                                    ['booking_date'] ??
                                                "",
                                          );
                                        }
                                        return Container();
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            ////
                            ///
                            ///
                            ///Past Bookings Cards
                            ExpansionTile(
                              title: const Text('Past Bookings'),
                              children: [
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collectionGroup('user_booking')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snap) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (snap.data == null) {
                                      return const Text("No Past Bookings");
                                    }

                                    var doc = snap.data.docs;

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: doc.length,
                                      itemBuilder: (context, index) {
                                        if (doc[index]['booking_status'] ==
                                                'completed' &&
                                            doc[index]['booking_accepted'] ==
                                                true) {
                                          return PastBookingCard(
                                            userID: doc[index]['userId'] ?? "",
                                            userName:
                                                doc[index]['user_name'] ?? "",
                                            bookingID:
                                                doc[index]['booking_id'] ?? "",
                                            bookingPlan: doc[index]
                                                    ['booking_plan'] ??
                                                "",
                                            bookingPrice: doc[index]
                                                    ['booking_price'] ??
                                                "",
                                            bookingdate: doc[index]
                                                    ['booking_date'] ??
                                                "",
                                          );
                                        }
                                        return Container();
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                showBranches == false
                    ? Container()
                    : Positioned(
                        top: 80,
                        left: 51,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: 280,
                          height: isHeightTobeIncreased ? 400 : 250,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('product_details')
                                  // .where("gym_id",
                                  //     isEqualTo: FirebaseAuth
                                  //         .instance.currentUser!.email)
                                  .where(
                                    'token',
                                    arrayContains:
                                        "enOny3LySKi3SppiNT8B3V:APA91bHV28q5C300EBMX0f2pTWHlvn96OCRzlnZEVo_hAtoIiDEhi_bjakLi5_DFM1XNe9r4qpwxhQIEPsRC0124jGYkMHYVkvNSYbrXuYYN6o17d6HmiPWr1N83gh95IqCNKgEX-zHG",
                                  )
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                //isHeightTobeIncreased

                                if (snapshot.data == null) {
                                  return Container();
                                }
                                if (snapshot.data.docs.length + 2 > 3) {
                                  isHeightTobeIncreased = true;
                                }
                                if (snapshot.data.docs.length + 2 <= 3) {
                                  isHeightTobeIncreased = false;
                                }
                                if (snapshot.data == ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                print(FirebaseAuth.instance.currentUser!.email);
                                List temp = snapshot.data.docs.toList();
                                if (temp.isEmpty) {
                                  return const Center(
                                    child: Text("No branches to show"),
                                  );
                                } else {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: ((context, index) {
                                      if (index == snapshot.data.docs.length) {
                                        return ListTile(
                                          trailing: const Icon(
                                            Icons.add,
                                            color: Colors.black54,
                                          ),
                                          title: const Text(
                                            'Add another Account',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onTap: () {
                                            print("Add another Login Session");
                                            Get.to(
                                              const LoginScreen(),
                                            );
                                          },
                                        );
                                      }
                                      return ListTile(
                                        title: Text(
                                          snapshot.data.docs[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text(
                                          snapshot.data.docs[index]['landmark'],
                                          style: const TextStyle(
                                            color: Color(0xffBDBDBD),
                                          ),
                                        ),
                                      );
                                    }),
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      color: Color(0xffD6D6D6),
                                    ),
                                    itemCount: snapshot.data.docs.length + 1,
                                  );
                                }
                              }),
                        ),
                      )
              ],
            );
          }),
    );
  }

  AppBar buildAppBar(BuildContext context,
      {required String? gymname,
      required bool? isGymOpened,
      required String? gymLocation,
      Function? leadingCallback}) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 80,
      backgroundColor: Colors.transparent,
      primary: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            leadingCallback!();
          },
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          )),
      title: Text(
        gymname!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
        ),
      ),
      bottom: PreferredSize(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                print("Open that Alert dialogue Box");
                setState(() {
                  showBranches = !showBranches;
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 57.0),
                    child: Text(
                      gymLocation!,
                      style: const TextStyle(
                        color: Color(0xffBDBDBD),
                      ),
                    ),
                  ),
                  Icon(
                    !showBranches
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: const Color(0xff130F26),
                    size: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset("Assets/Images/Search.png"),
                  hintText: 'Search',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 30, //set desired REAL HEIGHT
          width: 60, //set desired REAL WIDTH
          child: Transform.scale(
            transformHitTests: false,
            scale: 0.8,
            child: CupertinoSwitch(
              value: isGymOpened!,
              onChanged: (value) {
                FirebaseFirestoreAPi()
                    .updateGymStatusToFirestore(isGymOpened: value);
                print(value);
                setState(() {
                  status = value;
                });
                FirebaseFirestoreAPi()
                    .updateGymStatusToFirestore(isGymOpened: value);
              },
              activeColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Drawer buildDrawer(
    BuildContext context,
  ) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Stack(
        // shrinkWrap: true,
        children: [
          Column(
            children: [
              DrawerTitleWidget(
                callback: () {
                  Navigator.pop(context);
                },
              ),
              buildDrawerListItem(
                title: 'Change Password',
                iconData: 'lock',
              ),
              buildDrawerListItem(
                title: 'Notifications',
              ),
              buildDrawerListItem(
                title: 'Rate us',
                iconData: 'star',
              ),
              buildDrawerListItem(
                title: 'Support',
                iconData: 'message-question',
              ),
            ],
          ),
          Positioned(
            bottom: 150,
            left: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff292F3D),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 10,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile buildDrawerListItem(
      {required String? title, String? iconData = 'lock'}) {
    return ListTile(
      minLeadingWidth: 0,
      leading: Image.asset("Assets/Images/$iconData.png"),
      title: Text(
        title!,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }
}
