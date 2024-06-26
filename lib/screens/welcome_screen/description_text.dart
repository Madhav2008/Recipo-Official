import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    Key? key,
    required this.size,
    required this.index,
    required this.description,
  }) : super(key: key);

  final Size size;
  final int index;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: size.width * 0.038,
      ),
    );
  }
}
