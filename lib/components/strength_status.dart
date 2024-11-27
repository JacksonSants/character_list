import 'package:flutter/material.dart';

class StrengthBar extends StatelessWidget {
  final int strengthstatus;

  const StrengthBar({
    super.key,
    required this.strengthstatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: (strengthstatus >= 1) ? Colors.red : Colors.white,
        ),
        Icon(
          Icons.star,
          color: (strengthstatus >= 2) ? Colors.red : Colors.white,
        ),
        Icon(
          Icons.star,
          color: (strengthstatus >= 3) ? Colors.red : Colors.white,
        ),
        Icon(
          Icons.star,
          color: (strengthstatus >= 4) ? Colors.red : Colors.white,
        ),
        Icon(
          Icons.star,
          color: (strengthstatus >= 5) ? Colors.red : Colors.white,
        )
      ],
    );
  }
}
