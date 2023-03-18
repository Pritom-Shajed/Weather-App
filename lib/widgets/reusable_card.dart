import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Widget? cardChild;

  const ReusableCard({super.key, this.cardChild});


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(15),
        ),
        child: cardChild,
    );
  }
}
