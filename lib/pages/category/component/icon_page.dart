import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String? title;
  final IconData? icon;
  final Image? image;
  final VoidCallback? onPressed;

  const ActionButton({super.key, this.title, this.icon, this.image, this.onPressed});


  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      // padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
      child: Column(
        children: <Widget>[
          Icon(
            widget.icon,
            color: Color(0xff3f51b5),
          ),
          Text(
            widget.title as String,
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          )
        ],
      ),
    );
  }
}
