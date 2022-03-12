import 'package:flutter/material.dart';

class AllTimePay extends StatelessWidget {
  const AllTimePay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 95,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 27,left: 27),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Due payment',
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            // SizedBox(height: 5),
                            Text(
                              'For January',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          '₹ 500',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.7,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ListTile(
                        minVerticalPadding: 12,
                        leading: Container(
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            "Assets/import.png",
                            fit: BoxFit.cover,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        title: Column(
                          children: const [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Received from",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Vyam",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                          ],
                        ),
                        subtitle: const Text(
                          '05 Jan 2022',
                          style: TextStyle(
                            color: Colors.black38,
                            fontFamily: "Poppins",
                            fontSize: 9,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              "₹ 100",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              "Credited to bank account",
                              style: TextStyle(
                                color: Colors.black38,
                                fontFamily: "Poppins",
                                fontSize: 9,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        selected: true,
                        onTap: () {},
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}