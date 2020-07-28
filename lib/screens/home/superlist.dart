import 'package:churchpro/modals/supermarkets_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SuperList extends StatefulWidget {
  @override
  _SuperListState createState() => _SuperListState();
}

class _SuperListState extends State<SuperList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<List<Supermarkets>>(context);
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * (60 / 100),
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: provider.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/superdetail',
                              arguments: {
                                'selectedName': provider[index].superName,
                                ' selectedImage': provider[index].image,
                              });
                        },
                        child: Container(
                            height: 180.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color(0xFFC2E3FE)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                                provider[index].image,
                                                height: 40.0,
                                                width: 40.0)))),
                                SizedBox(height: 2.0),
                                Text(
                                  provider[index].superName,
                                  style: GoogleFonts.notoSans(
                                      fontSize: 17.0, color: Colors.white),
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
  }
}
