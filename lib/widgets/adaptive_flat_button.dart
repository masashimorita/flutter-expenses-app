import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  AdaptiveFlatButton(this.label, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              this.label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: this.onPressed,
          )
        : TextButton(
            child: Text(
              this.label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: this.onPressed,
          );
  }
}
