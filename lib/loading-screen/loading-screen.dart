import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        top: 20.0,
        left: 130.0,
        child: SvgPicture.asset(
          "assets/icons/loading.svg",
          height: 400.0,
          width: 200.0,
        ),
      ),
    );
  }
}
