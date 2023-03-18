import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? buttonChild;

  const CustomButton({super.key, this.buttonChild, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: buttonChild,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        fixedSize: Size(150, 20),
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        primary: Colors.black54,
        onPrimary: Colors.white,
        side: BorderSide(
          color: Colors.white54,
          width: 1,
        ),
        shape: StadiumBorder(),
      ),
    );
  }
}
