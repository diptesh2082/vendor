import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/app_colors.dart';

import '../../widgets/active_booking.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/drawer_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var status = false;
  final GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: buildAppBar(context),
        drawer: buildDrawer(context),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              status
                  ? Container()
                  : Center(
                      child: Image.asset("Assets/Images/no_bookings.png"),
                    ),
              !status
                  ? Container()
                  : ExpansionTile(
                      title: Text('Upcoming Bookings'),
                      textColor: Colors.black,
                      children: [
                        BookingCard(),
                        BookingCard(),
                        BookingCard(),
                      ],
                    ),
              !status
                  ? Container()
                  : ExpansionTile(
                      title: Text('Active Bookings Bookings'),
                      children: [
                        ActiveBookingCard(),
                        ActiveBookingCard(),
                      ],
                    ),
              !status
                  ? Container()
                  : ExpansionTile(
                      title: Text('Past Bookings'),
                      children: [
                        BookingCard(),
                        BookingCard(),
                        BookingCard(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 80,
      backgroundColor: Colors.transparent,
      primary: true,
      iconTheme: const IconThemeData(color: Colors.black),
      titleSpacing: 0,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          //TODO: See Opening Drawer;
        },
        icon: Image.asset(
          "Assets/Images/menu.png",
          scale: 1,
          color: Colors.black,
        ),
      ),
      title: const Text(
        'Transformers Gym',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
        ),
      ),
      bottom: PreferredSize(
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 57.0),
                  child: Text(
                    'Branch Barakar',
                    style: TextStyle(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                ),
              ],
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
              value: status,
              onChanged: (value) {
                setState(() {
                  status = value;
                });
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
