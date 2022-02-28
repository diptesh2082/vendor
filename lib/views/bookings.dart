import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'days/allTime.dart';
import 'days/days15.dart';
import 'days/days30.dart';
import 'days/days7.dart';
// import 'package:vyam/views/days/allTime.dart';
// import 'package:vyam/views/days/days15.dart';
// import 'package:vyam/views/days/days30.dart';
// import 'package:vyam/views/days/days7.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  var _getIndex = 0;

  bool _allTime = true;
  // ignore: non_constant_identifier_names
  bool _7Days = false;
  // ignore: non_constant_identifier_names
  bool _15Days = false;
  // ignore: non_constant_identifier_names
  bool _30Days = false;

  final Color _inactiveColor = HexColor("FFFFFF");
  final Color _maleColor = HexColor("292F3D");
  final Color _textInactive = HexColor("3A3A3A");
  final Color _textActive = HexColor("FFFFFF");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: HexColor("F5F5F5"),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: HexColor("3A3A3A"),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
              indicatorColor: HexColor("F5F5F5"),
              onTap: (index) {
                _getIndex = index;
                if (_getIndex == 0) {
                  setState(() {
                    _allTime = true;
                    _7Days = false;
                    _15Days = false;
                    _30Days = false;
                  });
                }
                if (_getIndex == 1) {
                  setState(() {
                    _allTime = false;
                    _7Days = true;
                    _15Days = false;
                    _30Days = false;
                  });
                }
                if (_getIndex == 2) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    _15Days = true;
                    _30Days = false;
                  });
                }
                if (_getIndex == 3) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    _15Days = false;
                    _30Days = true;
                  });
                }
              },
              tabs: [
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _allTime ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "All time",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _allTime ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _7Days ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "7 days",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _7Days ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _15Days ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "15 days",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _15Days ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _30Days ? _maleColor : _inactiveColor),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: Center(
                      child: Text(
                        "30 days",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: _30Days ? _textActive : _textInactive),
                      ),
                    ),
                  ),
                ),
              ]),
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Insights",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [AllTime(), Days_7(), Days_15(), Days_30()]),
      ),
    );
  }
}