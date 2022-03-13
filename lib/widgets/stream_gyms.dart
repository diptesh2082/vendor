import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class StreamForAllGyms extends StatelessWidget {
  const StreamForAllGyms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('product_details')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('product_details')
                      .doc('mahtab5752@gmail.com')
                      .collection('gym')
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot2) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot2.data.docs.length,
                        itemBuilder: (context, index) {
                          print(snapshot2.data.docs.length);
                          return Container(
                            color: Colors.red,
                            child: Text(
                              snapshot2.data.docs[index]['name'],
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
