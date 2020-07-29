import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Center(
        child: SpinKitSquareCircle(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );
  }
}
