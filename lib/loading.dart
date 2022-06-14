import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  Widget somewidget;
  Text  title;
  Loading({Key? key, required this.somewidget,required this.title}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      (() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => widget.somewidget,
            ),
          )
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        
      ],),
    );
  }
}
// https://papersbank-backend.herokuapp.com/