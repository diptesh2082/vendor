import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/Services/firebase_firestore_api.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:vyam_vandor/provider/firebase_streams_docs.dart';
import '../../widgets/active_booking.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/drawer_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../widgets/past_bookings.dart';

late List<BookingCard>? upCominglist = [];
late List<ActiveBookingCard>? _activeBookingsList = [];

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var status = true;
  final GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

  Future setUpcomingBookings() async {
    try {
      List<BookingCard> temp =
          await FirebaseFirestoreAPi().getUpComingBookings();
      setState(() {
        upCominglist = temp;
      });
    } catch (e) {
      print(" $e /////////////////");
    }
  }

  Future setActiveBookings() async {
    try {
      List<ActiveBookingCard> temp =
          await FirebaseFirestoreAPi().getUpActiveBookings();
      setState(() {
        _activeBookingsList = temp;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    setActiveBookings();
    setUpcomingBookings();
  }

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
                  backgroundColor: AppColors.backgroundColor,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  appBar: buildAppBar(context,
                      isGymOpened: snapshot.data!.get("gym_status"),
                      gymLocation: snapshot.data!.get("landmark"),
                      gymname: snapshot.data!.get("name")),
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
                                      // .where("vandorId",
                                      //     isEqualTo: "T@gmail.com")
                                      // .where("booking_status", isEqualTo: 'a'

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
                                            bookings: doc[index],
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
                    ? Positioned(
                        top: 80,
                        left: 51,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          width: 280,
                          height: 300,
                          child: ListView.separated(
                            itemBuilder: ((context, index) => const ListTile(
                                  title: Text(
                                    'Ghaziabad',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    'Branch Asansol',
                                    style: TextStyle(
                                      color: Color(0xfffBDBDBD),
                                    ),
                                  ),
                                )),
                            separatorBuilder: (context, index) => const Divider(
                              color: Color(0xffD6D6D6),
                            ),
                            itemCount: 4,
                          ),
                        ),
                      )
                    : Container()
              ],
            );
          }),
    );
  }

  var showBranches = false;

  AppBar buildAppBar(BuildContext context,
      {required String? gymname,
      required bool? isGymOpened,
      required String? gymLocation}) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 80,
      backgroundColor: Colors.transparent,
      primary: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleSpacing: 0,
      elevation: 0,
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

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      key: _drawerkey,
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
