import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RatingIcon extends StatelessWidget {
  final String iconName;
  final bool isActive;
  RatingIcon({required this.iconName, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/${iconName}.svg",
      height: 20,
      color: isActive ? Color(0xff47c901) : Colors.grey,
    );
  }
}
