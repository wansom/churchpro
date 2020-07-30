import 'package:churchpro/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperList extends StatefulWidget {
  @override
  _SuperListState createState() => _SuperListState();
}

class _SuperListState extends State<SuperList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('supermarkets').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mysnapshot = snapshot.data;
            return Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * (60 / 100),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: mysnapshot.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot supermarket =
                            mysnapshot.documents[index];
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 3.0),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/superdetail',
                                      arguments: {
                                        'selectedName':
                                            supermarket['supername'],
                                        ' selectedImage':
                                            supermarket['imageurl'],
                                      });
                                },
                                child: Container(
                                    height: 180.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Color(0xFFC2E3FE)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Hero(
                                            tag: index,
                                            child: Container(
                                                height: 75.0,
                                                width: 75.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Image.network(
                                                        supermarket['imageurl'],
                                                        height: 40.0,
                                                        width: 40.0)))),
                                        SizedBox(height: 2.0),
                                        Text(
                                          supermarket['supername'],
                                          style: GoogleFonts.notoSans(
                                              fontSize: 17.0,
                                              color: Colors.white),
                                        ),
                                        // Text(supermarkets[index].superStores,
                                        //     style: GoogleFonts.notoSans(
                                        //         fontSize: 17.0, color: Colors.amber))
                                      ],
                                    ))));
                      }),
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
