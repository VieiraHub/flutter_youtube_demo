import 'package:flutter/material.dart';

class WhatsHot extends StatefulWidget {
  @override
  _WhatsHotState createState() => _WhatsHotState();
}

class _WhatsHotState extends State<WhatsHot> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Text(
                "What's Hot",
                style: TextStyle(
                    fontSize: 25
                )
            )
        )
    );
  }
}
